import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/header.dart';
import 'package:si_proto/welcomePage/signup_form.dart';
import 'package:si_proto/welcomePage/constants_color.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ConstantsColor.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: SignUpForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
