import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/models/team_model.dart';
import 'package:si_proto/pages/signup/confirm_email_page.dart';
import 'package:si_proto/utils/constants_db_text,.dart';
import 'package:si_proto/utils/constants_text.dart';
import 'package:uuid/uuid.dart';

import '../components/info_dialog.dart';
import '../models/user_model.dart';
import '../pages/top/top_page.dart';

class ConnectionDb {
  static Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user == null) {
        throw FirebaseAuthException(code: ConstantsText.unexpectedError);
      }
      if (!user.emailVerified && context.mounted) {
        InfoDialog.snackBarNetral(context, ConstantsText.mailAuthUnfinished);
        return;
      }
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const TopPage();
          },
        ));
      }
    } on FirebaseAuthException catch (e) {
      _showLoginErrorMessage(context, e);
    }
  }

  static Future<void> registerUser(BuildContext context, String email,
      String password, String userName) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      if (user == null) {
        throw FirebaseAuthException(code: ConstantsText.unexpectedError);
      }
      await FirebaseFirestore.instance
          .collection(ConstantsDbText.dbCollectionUser)
          .doc(user.uid)
          .set({
        ConstantsDbText.docUserName: userName,
        ConstantsDbText.docTeamId: '',
        ConstantsDbText.docAssets: 0,
        ConstantsDbText.docEmail: user.email,
        ConstantsDbText.docImageUrl: ConstantsText.defaultImage
      });
      await user.sendEmailVerification();
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmEmailPage(email, password)),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showErrorRegisterMessage(context, e);
    }
  }

  static Future<void> registerTeam(
      BuildContext context, TeamModel teamModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(ConstantsDbText.dbCollectionTeams)
          .doc(const Uuid().v4())
          .set({
        'teamName': teamModel.teamName,
        'description': teamModel.description,
        'imageUrl': teamModel.imageUrl,
        'assets': teamModel.assets,
        'goalAmount': teamModel.goalAmount,
        'monthDeposit': teamModel.monthDeposit,
        'recruitmentNumbers': teamModel.recruitmentNumbers,
        'isPublic': teamModel.isPublic,
        'startDate': teamModel.startDate
      });
      //TODO:画像アップロード
      if (context.mounted) {
        InfoDialog.snackBarSuccess(context, 'チームの作成が完了しました。');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const TopPage();
          },
        ));
      }
    } on FirebaseAuthException catch (e) {
      _showErrorRegisterMessage(context, e);
    }
  }

  static Future<void> sendConfirmEmail(
      BuildContext context, String email, String password) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user != null) {
        await user.sendEmailVerification();
        if (context.mounted) {
          InfoDialog.snackBarNetral(context, '$email\nに認証メールを送信しました。');
        }
      }
    } on FirebaseAuthException {
      InfoDialog.snackBarError(context, ConstantsText.unexpectedError);
    }
  }

  static Future<void> updateEmail(BuildContext context, String email,
      String newEmail, String password) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user != null) {
        await user.updateEmail(newEmail);
        await FirebaseFirestore.instance
            .collection(ConstantsDbText.dbCollectionUser)
            .doc(user.uid)
            .update({ConstantsDbText.docEmail: newEmail});
        if (context.mounted) {
          await sendConfirmEmail(context, newEmail, password);
        }
      }
    } on FirebaseAuthException {
      InfoDialog.snackBarError(context, ConstantsText.unexpectedError);
    }
  }

  static Future<void> updateProfile(
      BuildContext context, String userName, Uint8List data) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection(ConstantsDbText.dbCollectionUser)
          .doc(uid)
          .update({ConstantsDbText.docUserName: userName});
      await uploadImage(uid, data);
      if (context.mounted) {
        InfoDialog.snackBarSuccess(context, 'プロフィールを保存しました');
      }
    } on FirebaseAuthException {
      InfoDialog.snackBarError(context, ConstantsText.unexpectedError);
    }
  }

  static Future<void> updatePassword(BuildContext context, String email,
      String newPassword, String password) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user != null) {
        await user.updatePassword(newPassword);
        if (context.mounted) {
          InfoDialog.snackBarSuccess(context, 'パスワードの変更が完了しました。');
        }
      }
    } on FirebaseAuthException {
      InfoDialog.snackBarError(context, ConstantsText.unexpectedError);
    }
  }

  static Future<void> sendResetPassword(
      BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        InfoDialog.snackBarNetral(context, '$email\nにパスワード再設定メールを送信しました。');
      }
    } on FirebaseAuthException {
      InfoDialog.snackBarError(context, ConstantsText.unexpectedError);
    }
  }

  static Future<void> uploadImage(String? uid, Uint8List data) async {
    if (data.isEmpty) {
      return;
    }
    UserModel user = await getUserModel();
    String uuid = const Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref().child(uuid);
    await storageRef.putData(data);
    String bucket = storageRef.bucket;
    if (user.imageUrl != ConstantsText.defaultImage) {
      await deleteImage(user.imageUrl);
    }
    await FirebaseFirestore.instance
        .collection(ConstantsDbText.dbCollectionUser)
        .doc(uid)
        .update({ConstantsDbText.docImageUrl: 'gs://$bucket/$uuid'});
  }

  static Future<void> deleteImage(String imageUrl) async {
    final storageRef = FirebaseStorage.instance.ref().child(imageUrl);
    await storageRef.delete();
  }

  static Future<TeamModel> getTeamModel(String teamId) async {
    final docRef = FirebaseFirestore.instance
        .collection(ConstantsDbText.dbCollectionTeams)
        .doc(teamId);
    final docSnapshot = await docRef.get();
    Map<String, dynamic>? data = docSnapshot.exists ? docSnapshot.data() : null;
    if (data == null) return const TeamModel();
    return TeamModel.fromJson(data);
  }

  static Future<UserModel> getUserModel() async {
    final uid = FirebaseAuth.instance.currentUser?.uid.toString();
    final docRef = FirebaseFirestore.instance
        .collection(ConstantsDbText.dbCollectionUser)
        .doc(uid);
    final docSnapshot = await docRef.get();
    Map<String, dynamic>? data =
        docSnapshot.exists ? docSnapshot.data() : null; //
    if (data == null) return const UserModel();
    return UserModel.fromJson(data);
  }

  static Future<String> getImageUrl(String image) async {
    final storage = FirebaseStorage.instance.refFromURL(image);
    String imageUrl = await storage.getDownloadURL();
    return imageUrl;
  }

  static void _showLoginErrorMessage(
      BuildContext context, FirebaseAuthException e) {
    String errorMessage = ConstantsText.unexpectedError;
    if (e.code == 'user-disabled') {
      errorMessage = ConstantsText.userDisabled;
    } else if (e.code == 'invalid-email') {
      errorMessage = ConstantsText.invalidEmail;
    } else if (e.code == 'user-not-found') {
      errorMessage = ConstantsText.userNotFound;
    } else if (e.code == 'wrong-password') {
      errorMessage = ConstantsText.wrongPassword;
    }
    InfoDialog.snackBarError(context, errorMessage);
  }

  static void _showErrorRegisterMessage(
      BuildContext context, FirebaseAuthException e) {
    String errorMessage = ConstantsText.unexpectedError;
    if (e.code == 'user-disabled') {
      errorMessage = ConstantsText.userDisabled;
    } else if (e.code == 'invalid-email') {
      errorMessage = ConstantsText.invalidEmail;
    } else if (e.code == 'email-already-in-use') {
      errorMessage = ConstantsText.emailAlreadyInUse;
    } else if (e.code == 'weak-password') {
      errorMessage = ConstantsText.weakPassword;
    }
    InfoDialog.snackBarError(context, errorMessage);
  }
}
