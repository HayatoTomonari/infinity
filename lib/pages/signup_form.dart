import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_button.dart';
import 'package:si_proto/components/custom_text_field.dart';

import '../components/info_dialog.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
    String userName = "";
    return Column(
      children: [
        CustomTextField(
          labelText: 'メールアドレス',
          hintText: 'メールアドレスを入力してください。',
          obscureText: false,
          onChangedFunction: (String value) => email = value,
        ),
        const SizedBox(height: 48),
        CustomTextField(
          labelText: 'パスワード',
          hintText: '6文字以上で入力してください。',
          obscureText: true,
          onChangedFunction: (String value) => password = value,
        ),
        const SizedBox(height: 48),
        CustomTextField(
          labelText: 'ユーザーネーム',
          hintText: '後から変更可能です。',
          obscureText: false,
          onChangedFunction: (String value) => userName = value,
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            labelText: 'アカウント登録',
            onPressedFunction: () =>
                _registerUser(context, email, password, userName),
          ),
        ),
      ],
    );
  }

  Future<void> _registerUser(BuildContext context, String email,
      String password, String userName) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({'userName': userName, 'teamId': '', 'assets': 0}); //
      }
    } on FirebaseAuthException catch (e) {
      _showErrorMessage(context, e);
    }
  }

  void _showErrorMessage(BuildContext context, FirebaseAuthException e) {
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
