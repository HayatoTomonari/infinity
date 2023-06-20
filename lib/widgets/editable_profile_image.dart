import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditableProfileImage extends StatefulWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const EditableProfileImage({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<EditableProfileImage> createState() => _EditableProfileImageState();
}

class _EditableProfileImageState extends State<EditableProfileImage> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final picker = ImagePicker();
    ImageProvider image = NetworkImage(widget.imagePath);
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: image,
                fit: BoxFit.cover,
                width: 128,
                height: 128,
                child: InkWell(
                    onTap: () async => await (BuildContext context) async {
                          int selectType = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  children: ["写真から選択", "写真を撮影"]
                                      .asMap()
                                      .entries
                                      .map((e) {
                                    return SimpleDialogOption(
                                      child: ListTile(
                                        title: Text(e.value),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(e.key),
                                    );
                                  }).toList(),
                                );
                              });
                          ImageSource imgSource = selectType == 0
                              ? ImageSource.gallery
                              : ImageSource.camera;
                          final pickedFile =  await picker.pickImage(source: imgSource);
                          if (pickedFile != null) {
                            setState(() {
                              //TODO:選択された画像に表示を切り替える。
                            });
                          }
                        }(context)),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(3),
                color: Colors.white,
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: color,
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
