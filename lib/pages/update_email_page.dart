import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

import '../components/custom_button.dart';
import '../components/custom_future_builder.dart';
import '../components/custom_text_field.dart';
import '../firebase/connection_db.dart';
import '../models/user_model.dart';

class UpdateEmailPage extends StatefulWidget {
  const UpdateEmailPage({super.key});

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  String password = "";
  String newEmail = "";
  UserModel user = const UserModel();
  late Future<bool> waitingProcess;

  Future<bool> getUser() async {
    UserModel getUser = await ConnectionDb.getUserModel();
    setState(() {
      user = getUser;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    waitingProcess = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('メールアドレス変更'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.deepPurple, Colors.pink])),
          ),
        ),
        body: CustomFutureBuilder(
            waitingProcess,
            Column(
              children: [
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 10, right: 50, left: 50),
                  child: SizedBox(
                    child: CustomTextField(
                      labelText: '現在のメールアドレス',
                      hintText: '',
                      obscureText: false,
                      onChangedFunction: (String value) => {},
                      icon: Icons.mail,
                      textColor: ConstantsColor.darkTextColor,
                      focusColor: ConstantsColor.darkFocusColor,
                      initialValue: user.email,
                      enabled: false,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
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
            )));
  }
}
