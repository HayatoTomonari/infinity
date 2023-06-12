import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/ConstantsColor.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '新しく始める方は',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ConstantsColor.kTextColorSecondary),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            //クリック時のイベント
          },
          child: Text(
            'こちら',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ConstantsColor.kTextColorPrimary),
          ),
        ),
      ],
    );
  }
}
