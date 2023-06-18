import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/models/team.dart';
import 'package:si_proto/pages/confirm_email.dart';
import 'package:si_proto/utils/constants_db_connection,.dart';
import 'package:si_proto/utils/constants_text.dart';

import '../components/info_dialog.dart';
import '../models/app_user.dart';
import '../pages/top_page.dart';

class ConnectionDb {
  static Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user == null) {
        throw FirebaseAuthException(
            code: ConstantsText.unexpectedError);
      }
      if (!user.emailVerified && context.mounted) {
        InfoDialog.snackBarNetral(
            context, ConstantsText.mailAuthUnfinished);
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
        throw FirebaseAuthException(
            code: ConstantsText.unexpectedError);
      }
      await FirebaseFirestore.instance.collection(ConstantsDbConnection.dbCollectionUser).doc(user.uid).set({
        ConstantsDbConnection.docUserName: userName,
        ConstantsDbConnection.docTeamId: '',
        ConstantsDbConnection.docAssets: 0,
        ConstantsDbConnection.docEmail: user.email,
        ConstantsDbConnection.docImageUrl: ConstantsText.defaultImage
      });
      await user.sendEmailVerification();
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmEmail(email, password)),
        );
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
            .collection(ConstantsDbConnection.dbCollectionUser)
            .doc(user.uid)
            .update({ConstantsDbConnection.docEmail: newEmail});
        if (context.mounted) {
          await sendConfirmEmail(context, newEmail, password);
        }
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

  static Future<Team> getTeam(String teamId) async {
    final docRef = FirebaseFirestore.instance.collection(ConstantsDbConnection.dbCollectionTeams).doc(teamId);
    final docSnapshot = await docRef.get();
    Map<String, dynamic>? data = docSnapshot.exists ? docSnapshot.data() : null;
    if (data == null) return const Team();
    return Team.fromJson(data);
  }

  static Future<AppUser> getAppUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid.toString();
    final docRef = FirebaseFirestore.instance.collection(ConstantsDbConnection.dbCollectionUser).doc(uid);
    final docSnapshot = await docRef.get();
    Map<String, dynamic>? data =
        docSnapshot.exists ? docSnapshot.data() : null; //
    if (data == null) return const AppUser();
    return AppUser.fromJson(data);
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
