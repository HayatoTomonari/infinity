import 'package:flutter/material.dart';
import 'package:si_proto/widgets/login_footer_widget.dart';
import 'package:si_proto/widgets/signin_form_widget.dart';
import 'package:si_proto/widgets/title_screen_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
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
                    child: TitleScreenWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: SignInFormWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: LoginFooterWidget(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
