import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:si_proto/components/custom_future_builder.dart';

class EditableImageWidget extends StatefulWidget {
  final String imagePath;
  final Function(Uint8List) action;

  const EditableImageWidget({Key? key, required this.imagePath, required this.action})
      : super(key: key);

  @override
  State<EditableImageWidget> createState() => _EditableImageWidgetState();
}

class _EditableImageWidgetState extends State<EditableImageWidget> {
  Uint8List bytes = Uint8List(0);
  late Future<bool> waitingProcess;

  Future<bool> networkImageToBytes() async {
    final response = await get(Uri.parse(widget.imagePath));
    setState(() {
      bytes = response.bodyBytes;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    waitingProcess = networkImageToBytes();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final picker = ImagePicker();

    return CustomFutureBuilder(
        waitingProcess,
        Center(
          child: Stack(
            children: [
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: MemoryImage(bytes),
                    fit: BoxFit.cover,
                    width: 128,
                    height: 128,
                    child: InkWell(
                        onTap: () async => await (BuildContext context) async {
                              await _pickImage(context, picker);
                            }(context)),
                  ),
                ),
              ),
              _buildIcon(color),
            ],
          ),
        ));
  }

  Widget _buildIcon(Color color) {
    return Positioned(
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
    );
  }

  Future<void> _pickImage(BuildContext context, ImagePicker picker) async {
    int selectType = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            children: ["写真から選択", "写真を撮影"].asMap().entries.map((e) {
              return SimpleDialogOption(
                child: ListTile(
                  title: Text(e.value),
                ),
                onPressed: () => Navigator.of(context).pop(e.key),
              );
            }).toList(),
          );
        });
    ImageSource imgSource =
        selectType == 0 ? ImageSource.gallery : ImageSource.camera;
    final pickedFile = await picker.pickImage(source: imgSource);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      setState(() {
        bytes = imageBytes;
        widget.action(imageBytes);
      });
    }
  }
}
