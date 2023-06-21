import 'package:flutter/material.dart';
import 'package:si_proto/widgets/header_widget.dart';

import '../widgets/team_card_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(children: [
      HeaderWidget(),
      TeamCardWidget(),
    ]));
  }
}
