import 'package:flutter/material.dart';
import 'package:si_proto/pages/signup_form.dart';

import '../widgets/title_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.pink,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 130),
                    child: TitleText(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                        child: Text("新規アカウント登録",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: SignUpForm(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
