import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_button.dart';
import 'package:si_proto/components/custom_text_field.dart';
import 'package:si_proto/firebase/connection_db.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/utils/constants_text.dart';

//TODO:登録する項目を増やす。(電話番号とか)
class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
    String userName = "";
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
          hintText: ConstantsText.pleaseEnterLeastSixChars,
          obscureText: true,
          onChangedFunction: (String value) => password = value,
          icon: Icons.lock_clock_outlined,
          textColor: ConstantsColor.lightTextColor,
          focusColor: ConstantsColor.lightFocusColor,
        ),
        const SizedBox(height: 48),
        CustomTextField(
          labelText: ConstantsText.userName,
          hintText: ConstantsText.canBeChangedLater,
          obscureText: false,
          onChangedFunction: (String value) => userName = value,
          icon: Icons.account_circle,
          textColor: ConstantsColor.lightTextColor,
          focusColor: ConstantsColor.lightFocusColor,
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            labelText: ConstantsText.accountRegistration,
            onPressedFunction: () =>
                ConnectionDb.registerUser(context, email, password, userName),
            textColor: ConstantsColor.lightButtonTextColor,
            backColor: ConstantsColor.lightButtonBackColor,
          ),
        ),
      ],
    );
  }
}
