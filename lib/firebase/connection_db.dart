import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/models/team_model.dart';
import 'package:si_proto/utils/constants_db_text,.dart';
import 'package:si_proto/utils/constants_text.dart';
import 'package:uuid/uuid.dart';

import '../components/info_dialog.dart';
import '../models/user_model.dart';
import '../utils/constants_validate_text.dart';

class ConnectionDb {
  static Future<bool> loginUser(
      BuildContext context, String email, String password) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user == null) {
        throw FirebaseAuthException(code: ConstantsText.unexpectedError);
      }
      if (!user.emailVerified && context.mounted) {
        InfoDialog.snackBarNetral(
            context, ConstantsValidateText.mailAuthUnfinished);
        return false;
      }
      return true;
    } on FirebaseAuthException catch (e) {
      _showLoginErrorMessage(context, e);
      return false;
    }
  }

  static Future<bool> registerUser(BuildContext context, String email,
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
        ConstantsDbText.docImageUrl: ConstantsDbText.defaultUserImage
      });
      await user.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      _showErrorRegisterMessage(context, e);
      return false;
    }
  }

  static Future<bool> registerTeam(
      BuildContext context, TeamModel teamModel, Uint8List imageData) async {
    try {
      String uuid = const Uuid().v4();
      await FirebaseFirestore.instance
          .collection(ConstantsDbText.dbCollectionTeams)
          .doc(uuid)
          .set({
        ConstantsDbText.docTeamName: teamModel.teamName,
        ConstantsDbText.docDescription: teamModel.description,
        ConstantsDbText.docImageUrl: teamModel.imageUrl,
        ConstantsDbText.docAssets: teamModel.assets,
        ConstantsDbText.docGoalAmount: teamModel.goalAmount,
        ConstantsDbText.docMonthDeposit: teamModel.monthDeposit,
        ConstantsDbText.docRecruitmentNumbers: teamModel.recruitmentNumbers,
        ConstantsDbText.docIsPublic: teamModel.isPublic,
        ConstantsDbText.docStartDate: teamModel.startDate
      });
      await uploadImage(teamModel.imageUrl, ConstantsDbText.defaultTeamImage,
          ConstantsDbText.dbCollectionTeams, uuid, imageData);
      if (context.mounted) {
        InfoDialog.snackBarSuccess(context, ConstantsText.teamCreationComplete);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      _showErrorRegisterMessage(context, e);
      return false;
    }
  }

  static Future<void> sendConfirmEmail(
      BuildContext context, String email, String password) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user == null) {
        throw FirebaseAuthException(code: ConstantsText.unexpectedError);
      }
      await user.sendEmailVerification();
      if (context.mounted) {
        InfoDialog.snackBarNetral(
            context, '$email${ConstantsText.sendConfirmEmailWithoutEmail}');
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
      if (user == null) {
        throw FirebaseAuthException(code: ConstantsText.unexpectedError);
      }
      await user.updateEmail(newEmail);
      await FirebaseFirestore.instance
          .collection(ConstantsDbText.dbCollectionUser)
          .doc(user.uid)
          .update({ConstantsDbText.docEmail: newEmail});
      if (context.mounted) {
        await sendConfirmEmail(context, newEmail, password);
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
      UserModel userModel = await getUserModel();
      await uploadImage(userModel.imageUrl, ConstantsDbText.defaultUserImage,
          ConstantsDbText.dbCollectionUser, uid, data);
      if (context.mounted) {
        InfoDialog.snackBarSuccess(context, ConstantsText.saveProfileCompleted);
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
      if (user == null) {
        throw FirebaseAuthException(code: ConstantsText.unexpectedError);
      }
      await user.updatePassword(newPassword);
      if (context.mounted) {
        InfoDialog.snackBarSuccess(
            context, ConstantsText.passwordChangeCompleted);
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
        InfoDialog.snackBarNetral(
            context, '$email${ConstantsText.sendRestPasswordWithoutEmail}');
      }
    } on FirebaseAuthException {
      InfoDialog.snackBarError(context, ConstantsText.unexpectedError);
    }
  }

  static Future<void> uploadImage(String imageUrl, String defaultImageUrl,
      String collectionText, String? uid, Uint8List data) async {
    if (data.isEmpty) {
      return;
    }
    String uuid = const Uuid().v4();
    final storageRef = FirebaseStorage.instance.ref().child(uuid);
    await storageRef.putData(data);
    String bucket = storageRef.bucket;
    if (imageUrl != defaultImageUrl) {
      await deleteImage(imageUrl);
    }
    await FirebaseFirestore.instance
        .collection(collectionText)
        .doc(uid)
        .update({
      ConstantsDbText.docImageUrl:
          '${ConstantsDbText.googleAppsScript}$bucket/$uuid'
    });
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
    return await storage.getDownloadURL();
  }

  static void _showLoginErrorMessage(
      BuildContext context, FirebaseAuthException e) {
    String errorMessage = ConstantsText.unexpectedError;
    if (e.code == 'user-disabled') {
      errorMessage = ConstantsValidateText.userDisabled;
    } else if (e.code == 'invalid-email') {
      errorMessage = ConstantsValidateText.invalidEmail;
    } else if (e.code == 'user-not-found') {
      errorMessage = ConstantsValidateText.userNotFound;
    } else if (e.code == 'wrong-password') {
      errorMessage = ConstantsValidateText.wrongPassword;
    }
    InfoDialog.snackBarError(context, errorMessage);
  }

  static void _showErrorRegisterMessage(
      BuildContext context, FirebaseAuthException e) {
    String errorMessage = ConstantsText.unexpectedError;
    if (e.code == 'user-disabled') {
      errorMessage = ConstantsValidateText.userDisabled;
    } else if (e.code == 'invalid-email') {
      errorMessage = ConstantsValidateText.invalidEmail;
    } else if (e.code == 'email-already-in-use') {
      errorMessage = ConstantsValidateText.emailAlreadyInUse;
    } else if (e.code == 'weak-password') {
      errorMessage = ConstantsValidateText.weakPassword;
    }
    InfoDialog.snackBarError(context, errorMessage);
  }
}
