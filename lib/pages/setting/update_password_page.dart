import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_future_builder.dart';
import 'package:si_proto/utils/constants_color.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../firebase/connection_db.dart';
import '../../models/user_model.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  String password = "";
  String email = "";
  String newPassword = "";
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
          title: const Text('パスワード変更'),
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
                    labelText: '現在のパスワード',
                    hintText: '現在のパスワードを入力してください。',
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: CustomTextField(
                    labelText: '新しいパスワード',
                    hintText: '新しいパスワードを入力してください。',
                    obscureText: true,
                    onChangedFunction: (String value) => newPassword = value,
                    icon: Icons.lock_clock_outlined,
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
                      labelText: 'パスワードを変更する',
                      onPressedFunction: () => ConnectionDb.updatePassword(
                          context, user.email, newPassword, password),
                      textColor: ConstantsColor.darkButtonTextColor,
                      backColor: ConstantsColor.darkButtonBackColor,
                    ),
                  ),
                ),
              ],
            )));
  }
}
