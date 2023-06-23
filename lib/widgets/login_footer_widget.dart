import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/pages/signup/signup_page.dart';
import 'package:si_proto/utils/constants_text.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ConstantsText.howToStartNew,
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
              MaterialPageRoute(builder: (context) => const SignUpPage()),
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
    );
  }
}
