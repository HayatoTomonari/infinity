import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/constants_color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Function onChangedFunction;

  const CustomTextField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.obscureText,
      required this.onChangedFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(color: ConstantsColor.kTextColorSecondary),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ConstantsColor.kAccentColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ConstantsColor.kTextColorSecondary,
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
