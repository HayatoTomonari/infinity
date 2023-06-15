import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/pages/signup_page.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '新しく始める方は',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ConstantsColor.kTextColor),
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
            'こちら',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ConstantsColor.kTextColor),
          ),
        ),
      ],
    );
  }
}
