import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_button.dart';
import 'package:si_proto/firebase/connection_db.dart';
import 'package:si_proto/pages/signin/forget_password_page.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/components/custom_text_field.dart';
import 'package:si_proto/utils/constants_text.dart';

import '../pages/top/top_page.dart';

class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    return Column(
      children: [
        CustomTextField(
          labelText: ConstantsText.mailAddress,
          hintText: ConstantsText.pleaseEnterYourEmail,
          obscureText: false,
          onChangedFunction: (String value) => email = value,
          icon: Icons.mail,
          textColor: ConstantsColor.lightTextColor,
          focusColor: ConstantsColor.lightFocusColor,
        ),
        const SizedBox(height: 48),
        CustomTextField(
          labelText: ConstantsText.password,
          hintText: ConstantsText.pleaseEnterYourPassword,
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
              ConstantsText.forgotYourPassword,
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
                      builder: (context) => const ForgetPasswordPage()),
                );
              },
              child: Text(
                ConstantsText.here,
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
            labelText: ConstantsText.login,
            onPressedFunction: () => _userLogin(context, email, password),
            textColor: ConstantsColor.lightButtonTextColor,
            backColor: ConstantsColor.lightButtonBackColor,
          ),
        ),
      ],
    );
  }

  void _userLogin(BuildContext context, String email, String password) async {
    bool result = await ConnectionDb.loginUser(context, email, password);
    if (context.mounted && result) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const TopPage();
        },
      ));
    }
  }
}
