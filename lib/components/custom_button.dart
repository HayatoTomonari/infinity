import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String labelText;
  final Function onPressedFunction;
  final Color textColor;
  final Color backColor;

  const CustomButton(
      {Key? key, required this.labelText, required this.onPressedFunction, required this.textColor, required this.backColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () async {
        await onPressedFunction();
      },
      child: Text(
        labelText,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
