import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_button.dart';
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
          child: CustomButton(labelText: 'ログイン', onPressedFunction: () => _loginUser(email, password, context),),
        ),
      ],
    );
  }

  Future<void> _loginUser(String email, String password, BuildContext context) async {
    try {
      final User? user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: email, password: password))
          .user;
      if (user != null &&
          context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TopPage(user.uid)),
        );
      }
    } catch (e) {
      //TODO:ログイン失敗時の処理
    }
  }
}
