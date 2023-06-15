import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../firebase/connection_db.dart';

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail(this.email, this.password, {super.key});
  final String email;
  final String password;
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 130),
                    child: Center(child: Text("infinity", style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold))),
                  ),
                  Text('$email\nに確認メールを送信しました。\nメール記載のリンクを開いて、認証を完了してください。'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        labelText: '確認メールを再送信する',
                        onPressedFunction: () => ConnectionDb.sendConfirmEmail(context, email, password),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        labelText: 'メールアドレス認証完了',
                        onPressedFunction: () => ConnectionDb.loginUser(email, password, context),
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
