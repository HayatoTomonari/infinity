import 'package:flutter/material.dart';
import 'package:si_proto/widgets/header_widget.dart';

import 'team_card_widget.dart';

class TopPageWidget extends StatelessWidget {
  const TopPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(children: [
      HeaderWidget(),
      TeamCardWidget(),
    ]));
  }
}
