import 'package:flutter/material.dart';
import 'package:si_proto/pages/team/team_create_page.dart';

import '../../components/custom_button.dart';
import '../../utils/constants_color.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
            child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  labelText: 'チームを作成する',
                  onPressedFunction: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TeamCreatePage()),
                  ),
                  textColor: ConstantsColor.darkButtonTextColor,
                  backColor: ConstantsColor.darkButtonBackColor,
                ))));
  }
}
