import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_button.dart';
import 'package:si_proto/components/info_dialog.dart';
import 'package:si_proto/models/app_user.dart';
import 'package:si_proto/pages/top_page.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/components/custom_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
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
          hintText: 'パスワードを入力してください。',
          obscureText: true,
          onChangedFunction: (String value) => password = value,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'パスワードを忘れた方は',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ConstantsColor.kTextColorSecondary),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                //TODO:パスワード再登録
              },
              child: Text(
                'こちら',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: ConstantsColor.kTextColorPrimary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            labelText: 'ログイン',
            onPressedFunction: () => _loginUser(email, password, context),
          ),
        ),
      ],
    );
  }

  Future<void> _loginUser(
      String email, String password, BuildContext context) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user == null) return;
      Map<String, dynamic>? data = await _getAppUser(user.uid); //
      if (data == null) return;
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopPage(AppUser.fromJson(data)),
            ));
      }
    } on FirebaseAuthException catch (e) {
      _showErrorMessage(context, e);
    }
  }

  void _showErrorMessage(BuildContext context, FirebaseAuthException e) {
    String errorMessage = "ログインに失敗しました。";
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

  Future<Map<String, dynamic>?> _getAppUser(String uid) async {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(uid); // DocumentReference
    final docSnapshot = await docRef.get(); // DocumentSnapshot
    return docSnapshot.exists ? docSnapshot.data() : null; //
  }
}
