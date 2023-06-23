import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

class CustomLongTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function onChangedFunction;
  final Color textColor;
  final Color focusColor;
  final String initialValue;
  final bool enabled;

  const CustomLongTextField(
      {Key? key,
        required this.labelText,
        required this.hintText,
        required this.onChangedFunction,
        required this.textColor,
        required this.focusColor,
        this.initialValue = '',
        this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        iconColor: ConstantsColor.kIconColor,
        labelText: labelText,
        labelStyle: TextStyle(color: focusColor),
        hintText: hintText,
        hintStyle:
        TextStyle(color: textColor.withOpacity(0.3)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: focusColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: textColor,
          ),
        ),
      ),
      onChanged: (String value) {
        onChangedFunction(value);
      },
      controller: TextEditingController(text: initialValue),
      enabled: enabled,
      keyboardType: TextInputType.multiline,
      maxLines: 10,
    );
  }
}
