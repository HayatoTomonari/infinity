import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Function onChangedFunction;
  final IconData icon;

  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.obscureText,
      required this.onChangedFunction,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: ConstantsColor.kTextColor),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        iconColor: ConstantsColor.kIconColor,
        labelText: labelText,
        labelStyle: const TextStyle(color: ConstantsColor.kFocusColor),
        hintText: hintText,
        hintStyle: TextStyle(color: ConstantsColor.kTextColor.withOpacity(0.3)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ConstantsColor.kFocusColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ConstantsColor.kTextColor,
          ),
        ),
      ),
      obscureText: obscureText,
      onTap: () {},
      onChanged: (String value) {
        onChangedFunction(value);
      },
    );
  }
}
