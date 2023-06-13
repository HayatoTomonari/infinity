import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/constants_color.dart';
import 'package:si_proto/welcomePage/custom_text_field.dart';

class signUp_form extends StatelessWidget {
  const signUp_form({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const custom_text_field(
          labelText: 'メールアドレス',
          hintText: 'メールアドレスを入力してください。',
          obscureText: false,
        ),
        const SizedBox(height: 48),
        const custom_text_field(
          labelText: 'パスワード',
          hintText: '英数字を含む8文字以上',
          obscureText: true,
        ),
        const SizedBox(height: 48),
        const custom_text_field(
          labelText: 'ユーザーネーム',
          hintText: '後から変更可能です',
          obscureText: true,
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
                            email: "_email", password: "_password"))
                    .user;
                if (user != null) {
                  print("ユーザ登録しました ${user.email} , ${user.uid}");
                }
              } catch (e) {
                print(e);
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
