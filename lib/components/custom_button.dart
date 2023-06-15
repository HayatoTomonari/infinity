import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

class CustomButton extends StatelessWidget {
  final String labelText;
  final Function onPressedFunction;

  const CustomButton(
      {Key? key, required this.labelText, required this.onPressedFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: ConstantsColor.kButtonTextColor,
        backgroundColor: ConstantsColor.kButtonBackColor,
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
            color: ConstantsColor.kButtonTextColor, fontSize: 18),
      ),
    );
  }
}
