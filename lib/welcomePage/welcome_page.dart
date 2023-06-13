import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/header.dart';
import 'package:si_proto/welcomePage/Footer.dart';
import 'package:si_proto/welcomePage/signIn_form.dart';
import 'package:si_proto/welcomePage/constants_color.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
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
                child: SignIn(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Footer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}