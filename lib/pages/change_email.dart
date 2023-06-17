import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../firebase/connection_db.dart';
import '../models/app_user.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  String password = "";
  String newEmail = "";
  AppUser user = const AppUser();

  Future getUser() async {
    AppUser getUser = await ConnectionDb.getAppUser();
    setState(() {
      user = getUser;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppBar(
          title: const Text('メールアドレス変更'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.deepPurple, Colors.pink])),
          ),
        ),
        const SizedBox(height: 48),
        Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 10, right: 50, left: 50),
          child: SizedBox(
            child: TextField(
              decoration: const InputDecoration(labelText: '現在のメールアドレス'),
              enabled: false,
              controller: TextEditingController(text: user.email),
            ),
          ),
        ),
        const SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: CustomTextField(
            labelText: 'パスワード',
            hintText: 'パスワードを入力してください。',
            obscureText: true,
            onChangedFunction: (String value) => password = value,
            icon: Icons.lock_clock_outlined,
            textColor: ConstantsColor.darkTextColor,
            focusColor: ConstantsColor.darkFocusColor,
          ),
        ),
        const SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
          child: CustomTextField(
            labelText: '新しいメールアドレス',
            hintText: '新しいメールアドレス',
            obscureText: false,
            onChangedFunction: (String value) => newEmail = value,
            icon: Icons.mail,
            textColor: ConstantsColor.darkTextColor,
            focusColor: ConstantsColor.darkFocusColor,
          ),
        ),
        const SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              labelText: '確認メールを送信',
              onPressedFunction: () => ConnectionDb.updateEmail(
                  context, user.email, newEmail, password),
              textColor: ConstantsColor.darkButtonTextColor,
              backColor: ConstantsColor.darkButtonBackColor,
            ),
          ),
        ),
      ],
    ));
  }
}
