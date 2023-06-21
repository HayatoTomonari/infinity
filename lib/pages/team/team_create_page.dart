import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:si_proto/components/custom_number_field.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:si_proto/utils/constants_text.dart';
import 'package:si_proto/widgets/date_picker_widget.dart';

import '../../components/custom_button.dart';
import '../../components/custom_drop_down.dart';
import '../../components/custom_drop_down_item.dart';
import '../../components/custom_future_builder.dart';
import '../../components/custom_long_text_field.dart';
import '../../components/custom_text_field.dart';
import '../../firebase/connection_db.dart';
import '../../widgets/editable_image_widget.dart';

class TeamCreatePage extends StatefulWidget {
  const TeamCreatePage({super.key});

  @override
  State<TeamCreatePage> createState() => _TeamCreatePageState();
}

class _TeamCreatePageState extends State<TeamCreatePage> {
  String teamName = '';
  String imagePath = '';
  String goalAmount = '0';
  String monthDeposit = '0';
  String recruitmentNumbers = '0';
  String startDate = '';
  Uint8List imageData = Uint8List(0);
  late Future<bool> waitingProcess;

  Future<bool> getTeamDefaultImage() async {
    String imageUrl =
        await ConnectionDb.getImageUrl(ConstantsText.defaultTeamImage);
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
    final publicSettingNotifier = ValueNotifier<String>('公開');

    return Scaffold(
        appBar: AppBar(
          title: const Text('新規チーム作成'),
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
                    action: (imageData) => this.imageData = imageData,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: CustomTextField(
                    labelText: 'チーム名称',
                    hintText: '例:軽井沢別荘シェア購入チーム',
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
                    labelText: 'チーム説明',
                    hintText: '',
                    onChangedFunction: (String value) => teamName = value,
                    textColor: ConstantsColor.darkTextColor,
                    focusColor: ConstantsColor.darkFocusColor,
                    initialValue: '詳細内容:\n\n参加条件:\n\nその他:\n\n',
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
                          onChangedFunction: (String value) =>
                              goalAmount = value,
                          textColor: ConstantsColor.darkTextColor,
                          focusColor: ConstantsColor.darkFocusColor,
                          initialValue: goalAmount,
                        ),
                      ),
                    ),
                    const Text(
                      '万円',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, left: 50, right: 5),
                      child: Text(
                        '目標金額は万単位で設定してください。',
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
                          labelText: '月預金',
                          onChangedFunction: (String value) =>
                              monthDeposit = value,
                          textColor: ConstantsColor.darkTextColor,
                          focusColor: ConstantsColor.darkFocusColor,
                          initialValue: monthDeposit,
                        ),
                      ),
                    ),
                    const Text(
                      '円',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, left: 50, right: 5),
                      child: Text(
                        '月預金とは、参加メンバーが1カ月に一度、チームに預金する設定額です。',
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
                          labelText: '募集人数',
                          onChangedFunction: (String value) =>
                              recruitmentNumbers = value,
                          textColor: ConstantsColor.darkTextColor,
                          focusColor: ConstantsColor.darkFocusColor,
                          initialValue: recruitmentNumbers,
                        ),
                      ),
                    ),
                    const Text(
                      '人',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, left: 50, right: 5),
                      child: Text(
                        '資金の使い道に応じて適切な参加人数を設定してください。\n共同購入などをお考えの場合は共同購入出来る人数を調べておく必要があります。',
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
                        'チーム公開設定',
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
                          children: const ['公開', '非公開'],
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
                      padding: EdgeInsets.only(
                          bottom: 15, left: 50, right: 5),
                      child: Text(
                        '非公開にするとアプリ内の検索で表示されません。',
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
                        '開始日',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    DatePickerWidget(
                      action: (DateTime dateTime) =>
                          startDate = dateTime.toString(),
                    )
                  ],
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 15, left: 50, right: 5),
                      child: Text(
                        '開始日になると募集が打ち切られ、メンバーの預金が開始されます。',
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
                      labelText: '入力内容確認',
                      onPressedFunction: () => {},
                      textColor: ConstantsColor.darkButtonTextColor,
                      backColor: ConstantsColor.darkButtonBackColor,
                    ),
                  ),
                ),
              ],
            ))));
  }
}
