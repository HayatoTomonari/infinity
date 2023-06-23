import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/custom_button.dart';
import '../../components/custom_long_text_field.dart';
import '../../components/custom_number_field.dart';
import '../../components/custom_text_field.dart';
import '../../firebase/connection_db.dart';
import '../../models/team_model.dart';
import '../../utils/constants_color.dart';

class TeamCreateConfirmPage extends StatelessWidget {
  const TeamCreateConfirmPage({required this.teamModel, super.key});
  final TeamModel teamModel;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy/MM/dd(E)', "ja_JP");
    final numberFormatter = NumberFormat("#,###");
    String startDate = dateFormatter.format(teamModel.startDate);
    String isPublic = teamModel.isPublic ? '公開' : '非公開';

    return Scaffold(
        appBar: AppBar(
          title: const Text('チーム登録確認'),
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
                labelText: 'チーム名称',
                hintText: '例:軽井沢別荘シェア購入チーム',
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
                labelText: 'チーム説明',
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
                      labelText: '目標金額',
                      onChangedFunction: (String value) => {},
                      textColor: ConstantsColor.darkTextColor,
                      focusColor: ConstantsColor.darkFocusColor,
                      initialValue: numberFormatter.format(teamModel.goalAmount),
                      enabled: false,
                    ),
                  ),
                ),
                const Text(
                  '円',
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
                      labelText: '月預金',
                      onChangedFunction: (String value) => {},
                      textColor: ConstantsColor.darkTextColor,
                      focusColor: ConstantsColor.darkFocusColor,
                      initialValue: numberFormatter.format(teamModel.monthDeposit),
                      enabled: false,
                    ),
                  ),
                ),
                const Text(
                  '円',
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
                      labelText: '募集人数',
                      onChangedFunction: (String value) => {},
                      textColor: ConstantsColor.darkTextColor,
                      focusColor: ConstantsColor.darkFocusColor,
                      initialValue: numberFormatter.format(teamModel.recruitmentNumbers),
                      enabled: false,
                    ),
                  ),
                ),
                const Text(
                  '人',
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
                    'チーム公開設定:$isPublic',
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
                    '開始日:$startDate',
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
                  labelText: 'チームを作成する',
                  onPressedFunction: () async =>
                      {await ConnectionDb.registerTeam(context, teamModel)},
                  textColor: ConstantsColor.darkButtonTextColor,
                  backColor: ConstantsColor.darkButtonBackColor,
                ),
              ),
            ),
          ],
        )));
  }
}
