import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/constants_text.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        const TextStyle(fontFamily: 'Exo', color: Colors.white).copyWith(
            fontSize: 65, letterSpacing: 35, fontWeight: FontWeight.w700);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(-(textStyle.letterSpacing! * .5), 0),
              child: Text(ConstantsText.appTitle, style: textStyle),
            ),
          ], // Edit from here...
        ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
        Text(ConstantsText.appSubTitle,
                style: textStyle.copyWith(
                    fontSize: 24,
                    letterSpacing: 20,
                    fontWeight: FontWeight.w400))
            .animate()
            .fadeIn(delay: 1.seconds, duration: .7.seconds),
      ], // to here.
    );
  }
}
