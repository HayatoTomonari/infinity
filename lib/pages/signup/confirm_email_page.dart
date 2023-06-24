import 'package:flutter/material.dart';
import 'package:si_proto/widgets/title_screen_widget.dart';

import '../../components/custom_button.dart';
import '../../firebase/connection_db.dart';
import '../../utils/constants_color.dart';
import '../../utils/constants_text.dart';
import '../top/top_page.dart';

class ConfirmEmailPage extends StatelessWidget {
  const ConfirmEmailPage(this.email, this.password, {super.key});
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
                      child: TitleScreenWidget()),
                  Text('$email${ConstantsText.checkVerificationEmail}'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        labelText: ConstantsText.resendConfirmEmail,
                        onPressedFunction: () => ConnectionDb.sendConfirmEmail(
                            context, email, password),
                        textColor: ConstantsColor.lightButtonTextColor,
                        backColor: ConstantsColor.lightButtonBackColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        labelText: ConstantsText.emailVerificationCompleted,
                        onPressedFunction: () => _userLogin(context),
                        textColor: ConstantsColor.lightButtonTextColor,
                        backColor: ConstantsColor.lightButtonBackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _userLogin(BuildContext context) async {
    bool result = await ConnectionDb.loginUser(context, email, password);
    if (context.mounted && result) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const TopPage();
        },
      ));
    }
  }
}
