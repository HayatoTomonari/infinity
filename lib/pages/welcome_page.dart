import 'package:flutter/material.dart';
import 'package:si_proto/widgets/header.dart';
import 'package:si_proto/widgets/Footer.dart';
import 'package:si_proto/pages/signin_form.dart';
import 'package:si_proto/utils/constants_color.dart';

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