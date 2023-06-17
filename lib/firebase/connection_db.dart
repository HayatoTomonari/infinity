import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/models/team.dart';
import 'package:si_proto/pages/confirm_email.dart';

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
      if (user == null) return;
      if (!user.emailVerified && context.mounted) {
        InfoDialog.snackBarNetral(
            context, 'メール認証が未完了です。\nメール記載のリンクを開いて、認証を完了してください。');
        return;
      }
      Map<String, dynamic>? userData = await _getAppUser(user.uid);
      if (userData == null) return;
      AppUser appUser = AppUser.fromJson(userData);
      Team team = await _getTeam(appUser.teamId);
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return TopPage(appUser, team);
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
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({'userName': userName, 'teamId': '', 'assets': 0});
        user.sendEmailVerification();
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmEmail(email, password)),
          );
        }
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
        user.sendEmailVerification();
        if (context.mounted) {
          InfoDialog.snackBarNetral(context, '$email\nに認証メールを送信しました。');
        }
      }
    } on FirebaseAuthException {
      String errorMessage = "予期せぬエラーが発生しました。\nしばらく時間を置いてから再度お試しください。";
      InfoDialog.snackBarError(context, errorMessage);
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
      String errorMessage = "予期せぬエラーが発生しました。\nしばらく時間を置いてから再度お試しください。";
      InfoDialog.snackBarError(context, errorMessage);
    }
  }

  static Future<Team> _getTeam(String teamId) async {
    final docRef = FirebaseFirestore.instance.collection("teams").doc(teamId);
    final docSnapshot = await docRef.get();
    var data = docSnapshot.exists ? docSnapshot.data() : null;
    if (data == null) return const Team();
    return Team.fromJson(data);
  }

  static Future<Map<String, dynamic>?> _getAppUser(String uid) async {
    final docRef = FirebaseFirestore.instance.collection("users").doc(uid);
    final docSnapshot = await docRef.get();
    return docSnapshot.exists ? docSnapshot.data() : null; //
  }

  static void _showLoginErrorMessage(
      BuildContext context, FirebaseAuthException e) {
    String errorMessage = "予期せぬエラーが発生しました。\nしばらく時間を置いてから再度お試しください。";
    if (e.code == 'user-disabled') {
      errorMessage = 'そのメールアドレスは利用できません。';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'メールアドレスが正しくありません。';
    } else if (e.code == 'user-not-found') {
      errorMessage = 'ユーザーが見つかりません。';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'パスワードが誤っています。';
    }
    InfoDialog.snackBarError(context, errorMessage);
  }

  static void _showErrorRegisterMessage(
      BuildContext context, FirebaseAuthException e) {
    String errorMessage = "予期せぬエラーが発生しました。\nしばらく時間を置いてから再度お試しください。";
    if (e.code == 'user-disabled') {
      errorMessage = 'そのメールアドレスは利用できません。';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'メールアドレスの形式が正しくありません。';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'このメールアドレスは既に使用されています。';
    } else if (e.code == 'weak-password') {
      errorMessage = 'パスワードは6文字以上で設定してください。';
    }
    InfoDialog.snackBarError(context, errorMessage);
  }
}
