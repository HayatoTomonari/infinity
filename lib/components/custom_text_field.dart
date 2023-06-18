import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Function onChangedFunction;
  final IconData icon;
  final Color textColor;
  final Color focusColor;
  final String initialValue;
  final bool enabled;

  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.obscureText,
      required this.onChangedFunction,
      required this.icon,
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
        prefixIcon: Icon(icon),
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
      obscureText: obscureText,
      onTap: () {},
      onChanged: (String value) {
        onChangedFunction(value);
      },
      controller: TextEditingController(text: initialValue),
      enabled: enabled,
    );
  }
}
