import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_button.dart';
import 'package:si_proto/firebase/connection_db.dart';
import 'package:si_proto/pages/forget_password.dart';
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
          icon: Icons.mail,
          textColor: ConstantsColor.lightTextColor,
          focusColor: ConstantsColor.lightFocusColor,
        ),
        const SizedBox(height: 48),
        CustomTextField(
          labelText: 'パスワード',
          hintText: 'パスワードを入力してください。',
          obscureText: true,
          onChangedFunction: (String value) => password = value,
          icon: Icons.lock_clock_outlined,
          textColor: ConstantsColor.lightTextColor,
          focusColor: ConstantsColor.lightFocusColor,
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
                  .copyWith(color: ConstantsColor.lightTextColor),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgetPassword()),
                );
              },
              child: Text(
                'こちら',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: ConstantsColor.lightTextColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            labelText: 'ログイン',
            onPressedFunction: () =>
                ConnectionDb.loginUser(email, password, context),
            textColor: ConstantsColor.lightButtonTextColor,
            backColor: ConstantsColor.lightButtonBackColor,
          ),
        ),
      ],
    );
  }
}
