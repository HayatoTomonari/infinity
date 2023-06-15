import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/components/custom_text_field.dart';

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
          hintText: '英数字を含む8文字以上で入力してください。',
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
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ConstantsColor.kButtonTextColorPrimary,
              backgroundColor: ConstantsColor.kButtonColorPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              try {
                final User? user = (await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password))
                    .user;
                if (user != null) {
                  //TODO:テスト用コード
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .set({
                    'userName': userName,
                    'groupId': '1234',
                    'assets': 500
                  }); //
                }
              } catch (e) {
                //TODO:ユーザー登録失敗時の処理。
              }
            },
            child: Text(
              'アカウント登録',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ConstantsColor.kButtonTextColorPrimary, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
