import 'package:flutter/material.dart';
import 'package:si_proto/utils/constants_color.dart';

class CustomDropDownItem extends StatelessWidget {
  const CustomDropDownItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 16.0,
      ),
      child: Text(
        item,
        style: const TextStyle(
          color: ConstantsColor.darkTextColor,
        ),
      ),
    );
  }
}