import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

import '../../components/custom_button.dart';
import '../../components/custom_future_builder.dart';
import '../../components/custom_text_field.dart';
import '../../firebase/connection_db.dart';
import '../../models/user_model.dart';
import '../../utils/constants_text.dart';
import '../../widgets/editable_image_widget.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String userName = '';
  String comment = '';
  String imagePath = '';
  Uint8List imageData = Uint8List(0);
  late Future<bool> waitingProcess;

  Future<bool> getUserNameAndImagePath() async {
    UserModel userModel = await ConnectionDb.getUserModel();
    String imageUrl = await ConnectionDb.getImageUrl(userModel.imageUrl);
    setState(() {
      userName = userModel.userName;
      imagePath = imageUrl;
      comment = userModel.comment;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    waitingProcess = getUserNameAndImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstantsText.profileEdit),
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
                    imageBytesUpdateFunc: (imageData) =>
                        this.imageData = imageData,
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: CustomTextField(
                    labelText: ConstantsText.userName,
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: CustomTextField(
                    labelText: ConstantsText.comment,
                    hintText: '',
                    obscureText: false,
                    onChangedFunction: (String value) => comment = value,
                    icon: Icons.comment,
                    textColor: ConstantsColor.darkTextColor,
                    focusColor: ConstantsColor.darkFocusColor,
                    initialValue: comment,
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      labelText: ConstantsText.saveProfile,
                      onPressedFunction: () => ConnectionDb.updateProfile(
                          context, userName, comment, imageData),
                      textColor: ConstantsColor.darkButtonTextColor,
                      backColor: ConstantsColor.darkButtonBackColor,
                    ),
                  ),
                ),
              ],
            )));
  }
}
