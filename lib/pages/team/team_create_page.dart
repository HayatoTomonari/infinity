import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_number_field.dart';
import 'package:si_proto/pages/team/team_create_confirm_page.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/utils/constants_db_text,.dart';
import 'package:si_proto/utils/constants_text.dart';
import 'package:si_proto/utils/constants_validate_text.dart';
import 'package:si_proto/widgets/date_picker_widget.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drop_down.dart';
import '../../components/custom_drop_down_item.dart';
import '../../components/custom_future_builder.dart';
import '../../components/custom_long_text_field.dart';
import '../../components/custom_text_field.dart';
import '../../components/info_dialog.dart';
import '../../firebase/connection_db.dart';
import '../../models/team_model.dart';
import '../../widgets/editable_image_widget.dart';

class TeamCreatePage extends StatefulWidget {
  const TeamCreatePage({super.key});

  @override
  State<TeamCreatePage> createState() => _TeamCreatePageState();
}

class _TeamCreatePageState extends State<TeamCreatePage> {
  final publicSettingNotifier = ValueNotifier<String>(ConstantsText.public);
  String teamName = '';
  String description = ConstantsText.exampleTeamDescription;
  String imagePath = '';
  String goalAmount = '0';
  String monthDeposit = '0';
  String recruitmentNumbers = '0';
  String startDate = DateTime.now().toString();
  Uint8List imageData = Uint8List(0);
  late Future<bool> waitingProcess;

  Future<bool> getTeamDefaultImage() async {
    String imageUrl =
        await ConnectionDb.getImageUrl(ConstantsDbText.defaultTeamImage);
    setState(() {
      imagePath = imageUrl;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    waitingProcess = getTeamDefaultImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstantsText.newCreateTeam),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.deepPurple, Colors.pink])),
          ),
        ),
        body: CustomFutureBuilder(
            waitingProcess,
            SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: EditableImageWidget(
                    imagePath: imagePath,
                    imageBytesUpdateFunc: (imageData) =>
                        this.imageData = imageData,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: CustomTextField(
                    labelText: ConstantsText.teamName,
                    hintText: ConstantsText.exampleTeamName,
                    obscureText: false,
                    onChangedFunction: (String value) => teamName = value,
                    icon: Icons.drive_file_rename_outline,
                    textColor: ConstantsColor.darkTextColor,
                    focusColor: ConstantsColor.darkFocusColor,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: CustomLongTextField(
                    labelText: ConstantsText.teamDescription,
                    hintText: '',
                    onChangedFunction: (String value) => description = value,
                    textColor: ConstantsColor.darkTextColor,
                    focusColor: ConstantsColor.darkFocusColor,
                    initialValue: description,
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
                          onChangedFunction: (String value) =>
                              goalAmount = value,
                          textColor: ConstantsColor.darkTextColor,
                          focusColor: ConstantsColor.darkFocusColor,
                          initialValue: goalAmount,
                        ),
                      ),
                    ),
                    const Text(
                      ConstantsText.tenThousandYen,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, left: 50, right: 5),
                      child: Text(
                        ConstantsText.goalAmountDescription,
                        style: TextStyle(fontSize: 10),
                      ),
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
                          onChangedFunction: (String value) =>
                              monthDeposit = value,
                          textColor: ConstantsColor.darkTextColor,
                          focusColor: ConstantsColor.darkFocusColor,
                          initialValue: monthDeposit,
                        ),
                      ),
                    ),
                    const Text(
                      ConstantsText.yen,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, left: 50, right: 5),
                      child: Text(
                        ConstantsText.monthDepositDescription,
                        style: TextStyle(fontSize: 10),
                      ),
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
                          onChangedFunction: (String value) =>
                              recruitmentNumbers = value,
                          textColor: ConstantsColor.darkTextColor,
                          focusColor: ConstantsColor.darkFocusColor,
                          initialValue: recruitmentNumbers,
                        ),
                      ),
                    ),
                    const Text(
                      ConstantsText.person,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, left: 50, right: 5),
                      child: Text(
                        ConstantsText.recruitmentNumbersDescription,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 50, right: 20),
                      child: Text(
                        ConstantsText.teamVisibilitySettings,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: SizedBox(
                        width: 300,
                        child: CustomDropDown<String>(
                          valueNotifier: publicSettingNotifier,
                          itemWidgetBuilder: (int index, String item) =>
                              CustomDropDownItem(item: item),
                          children: const [
                            ConstantsText.public,
                            ConstantsText.private
                          ],
                          onChanged: (String value) {
                            publicSettingNotifier.value = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, left: 50, right: 5),
                      child: Text(
                        ConstantsText.publicSettingDescription,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 50, right: 20),
                      child: Text(
                        ConstantsText.startDate,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    DatePickerWidget(
                      dateTimeUpdateFunc: (DateTime dateTime) =>
                          startDate = dateTime.toString(),
                    )
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, left: 50, right: 5),
                      child: Text(
                        ConstantsText.startDateDescription,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      labelText: ConstantsText.confirmInputContent,
                      onPressedFunction: () => _registerTeamModel(),
                      textColor: ConstantsColor.darkButtonTextColor,
                      backColor: ConstantsColor.darkButtonBackColor,
                    ),
                  ),
                ),
              ],
            ))));
  }

  void _registerTeamModel() async {
    if (!_validateTeamModel()) {
      return;
    }
    TeamModel teamModel = _convertTeamModel();
    if (context.mounted) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return TeamCreateConfirmPage(teamModel: teamModel, imageData: imageData,);
        },
      ));
    }
  }

  TeamModel _convertTeamModel() {
    return TeamModel(
        teamName: teamName,
        description: description,
        imageUrl: imagePath,
        assets: 0,
        //FIXME:入力が万円の為、10000を掛けている。
        goalAmount: int.parse(goalAmount) * 10000,
        monthDeposit: int.parse(monthDeposit),
        recruitmentNumbers: int.parse(recruitmentNumbers),
        isPublic: publicSettingNotifier.value == ConstantsText.public,
        startDate: DateTime.parse(startDate));
  }

  bool _validateTeamModel() {
    if (teamName.isEmpty) {
      InfoDialog.snackBarError(context, ConstantsValidateText.invalidTeamName);
      return false;
    }
    int? amount = int.tryParse(goalAmount);
    if (amount == null) {
      InfoDialog.snackBarError(
          context, ConstantsValidateText.invalidGoalAmount);
      return false;
    }
    if (amount < 0) {
      InfoDialog.snackBarError(context, ConstantsValidateText.zeroGoalAmount);
      return false;
    }
    int? deposit = int.tryParse(monthDeposit);
    if (deposit == null) {
      InfoDialog.snackBarError(
          context, ConstantsValidateText.invalidMonthDeposit);
      return false;
    }
    if (deposit < 0) {
      InfoDialog.snackBarError(context, ConstantsValidateText.zeroMonthDeposit);
      return false;
    }
    int? numbers = int.tryParse(recruitmentNumbers);
    if (numbers == null) {
      InfoDialog.snackBarError(
          context, ConstantsValidateText.invalidRecruitmentNumbers);
      return false;
    }
    if (numbers < 0) {
      InfoDialog.snackBarError(
          context, ConstantsValidateText.zeroRecruitmentNumbers);
      return false;
    }
    DateTime? dateTime = DateTime.tryParse(startDate);
    if (dateTime == null) {
      InfoDialog.snackBarError(context, ConstantsValidateText.invalidStartDate);
      return false;
    }
    if (dateTime.isBefore(DateTime.now())) {
      InfoDialog.snackBarError(context, ConstantsValidateText.zeroStartDate);
      return false;
    }
    return true;
  }
}
