import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/constants_color.dart';
import 'package:si_proto/welcomePage/custom_text_field.dart';

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
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ConstantsColor.kButtonTextColorPrimary,
              backgroundColor: ConstantsColor.kButtonColorPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              //TODO:ログイン機能
            },
            child: Text(
              'ログイン',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: ConstantsColor.kButtonTextColorPrimary, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
