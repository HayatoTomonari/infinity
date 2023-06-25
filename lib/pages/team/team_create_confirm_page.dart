import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:si_proto/utils/constants_text.dart';

import '../../components/custom_button.dart';
import '../../components/custom_long_text_field.dart';
import '../../components/custom_number_field.dart';
import '../../components/custom_text_field.dart';
import '../../firebase/connection_db.dart';
import '../../models/team_model.dart';
import '../../utils/constants_color.dart';
import '../top/top_page.dart';

class TeamCreateConfirmPage extends StatelessWidget {
  const TeamCreateConfirmPage({required this.teamModel, required this.imageData, super.key});
  final TeamModel teamModel;
  final Uint8List imageData;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy/MM/dd(E)', "ja_JP");
    final numberFormatter = NumberFormat("#,###");
    String startDate = dateFormatter.format(teamModel.startDate);
    String isPublic =
        teamModel.isPublic ? ConstantsText.public : ConstantsText.private;

    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstantsText.teamRegistrationConfirm),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.deepPurple, Colors.pink])),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: CustomTextField(
                labelText: ConstantsText.teamName,
                hintText: ConstantsText.exampleTeamName,
                obscureText: false,
                onChangedFunction: (String value) => {},
                icon: Icons.drive_file_rename_outline,
                textColor: ConstantsColor.darkTextColor,
                focusColor: ConstantsColor.darkFocusColor,
                initialValue: teamModel.teamName,
                enabled: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: CustomLongTextField(
                labelText: ConstantsText.teamDescription,
                hintText: '',
                onChangedFunction: (String value) => {},
                textColor: ConstantsColor.darkTextColor,
                focusColor: ConstantsColor.darkFocusColor,
                initialValue: teamModel.description,
                enabled: false,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 50, right: 5),
                  child: SizedBox(
                    width: 200,
                    child: CustomNumberField(
                      labelText: ConstantsText.goalAmount,
                      onChangedFunction: (String value) => {},
                      textColor: ConstantsColor.darkTextColor,
                      focusColor: ConstantsColor.darkFocusColor,
                      initialValue:
                          numberFormatter.format(teamModel.goalAmount),
                      enabled: false,
                    ),
                  ),
                ),
                const Text(
                  ConstantsText.yen,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 50, right: 5),
                  child: SizedBox(
                    width: 200,
                    child: CustomNumberField(
                      labelText: ConstantsText.monthDeposit,
                      onChangedFunction: (String value) => {},
                      textColor: ConstantsColor.darkTextColor,
                      focusColor: ConstantsColor.darkFocusColor,
                      initialValue:
                          numberFormatter.format(teamModel.monthDeposit),
                      enabled: false,
                    ),
                  ),
                ),
                const Text(
                  ConstantsText.yen,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 50, right: 5),
                  child: SizedBox(
                    width: 200,
                    child: CustomNumberField(
                      labelText: ConstantsText.recruitmentNumbers,
                      onChangedFunction: (String value) => {},
                      textColor: ConstantsColor.darkTextColor,
                      focusColor: ConstantsColor.darkFocusColor,
                      initialValue:
                          numberFormatter.format(teamModel.recruitmentNumbers),
                      enabled: false,
                    ),
                  ),
                ),
                const Text(
                  ConstantsText.person,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 50, right: 20),
                  child: Text(
                    '${ConstantsText.teamVisibilitySettings}$isPublic',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 50, right: 5),
                  child: Text(
                    '${ConstantsText.startDate}$startDate',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  labelText: ConstantsText.creatingTeam,
                  onPressedFunction: () async => {await _registerTeam(context)},
                  textColor: ConstantsColor.darkButtonTextColor,
                  backColor: ConstantsColor.darkButtonBackColor,
                ),
              ),
            ),
          ],
        )));
  }

  _registerTeam(BuildContext context) async {
    bool result = await ConnectionDb.registerTeam(context, teamModel, imageData);
    if (context.mounted && result) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const TopPage();
        },
      ));
    }
  }
}
