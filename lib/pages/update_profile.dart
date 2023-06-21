import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

import '../components/custom_button.dart';
import '../components/custom_future_builder.dart';
import '../components/custom_text_field.dart';
import '../firebase/connection_db.dart';
import '../models/app_user.dart';
import '../widgets/editable_image_widget.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String userName = '';
  String imagePath = '';
  Uint8List imageData = Uint8List(0);
  late Future<bool> waitingProcess;

  Future<bool> getUser() async {
    AppUser appUser = await ConnectionDb.getAppUser();
    String imageUrl = await ConnectionDb.getImageUrl(appUser.imageUrl);
    setState(() {
      userName = appUser.userName;
      imagePath = imageUrl;
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
          title: const Text('プロフィール編集'),
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
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: EditableImageWidget(
                    imagePath: imagePath,
                    action: (imageData) => this.imageData = imageData,
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: CustomTextField(
                    labelText: 'ユーザーネーム',
                    hintText: '',
                    obscureText: false,
                    onChangedFunction: (String value) => userName = value,
                    icon: Icons.drive_file_rename_outline,
                    textColor: ConstantsColor.darkTextColor,
                    focusColor: ConstantsColor.darkFocusColor,
                    initialValue: userName,
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      labelText: 'プロフィールを保存',
                      onPressedFunction: () => ConnectionDb.updateProfile(
                          context,
                          userName,
                          imageData),
                      textColor: ConstantsColor.darkButtonTextColor,
                      backColor: ConstantsColor.darkButtonBackColor,
                    ),
                  ),
                ),
              ],
            )));
  }
}
