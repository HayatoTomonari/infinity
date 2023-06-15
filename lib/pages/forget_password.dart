import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../firebase/connection_db.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    String email = "";
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 130),
                    child: Center(
                        child: Text("infinity",
                            style: TextStyle(
                                fontSize: 100, fontWeight: FontWeight.bold))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomTextField(
                      labelText: 'メールアドレス',
                      hintText: 'メールアドレスを入力してください。',
                      obscureText: false,
                      onChangedFunction: (String value) => email = value,
                      icon: Icons.mail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        labelText: 'パスワード再設定メールを送信',
                        onPressedFunction: () =>
                            ConnectionDb.sendResetPassword(context, email),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
