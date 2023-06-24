import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_future_builder.dart';
import 'package:si_proto/utils/constants_color.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../firebase/connection_db.dart';
import '../../models/user_model.dart';
import '../../utils/constants_text.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  String password = "";
  String email = "";
  String newPassword = "";
  UserModel userModel = const UserModel();
  late Future<bool> waitingProcess;

  Future<bool> getUserModel() async {
    UserModel getUser = await ConnectionDb.getUserModel();
    setState(() {
      userModel = getUser;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    waitingProcess = getUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstantsText.changePassword),
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
                      labelText: ConstantsText.currentEmail,
                      hintText: '',
                      obscureText: false,
                      onChangedFunction: (String value) => {},
                      icon: Icons.mail,
                      textColor: ConstantsColor.darkTextColor,
                      focusColor: ConstantsColor.darkFocusColor,
                      initialValue: userModel.email,
                      enabled: false,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: CustomTextField(
                    labelText: ConstantsText.currentPassword,
                    hintText: ConstantsText.pleaseEnterCurrentPassword,
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
                    labelText: ConstantsText.newPassword,
                    hintText: ConstantsText.pleaseEnterNewPassword,
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
                      labelText: ConstantsText.changingPassword,
                      onPressedFunction: () => ConnectionDb.updatePassword(
                          context, userModel.email, newPassword, password),
                      textColor: ConstantsColor.darkButtonTextColor,
                      backColor: ConstantsColor.darkButtonBackColor,
                    ),
                  ),
                ),
              ],
            )));
  }
}
