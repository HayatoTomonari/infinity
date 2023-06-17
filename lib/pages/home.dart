import 'package:flutter/material.dart';
import 'package:si_proto/widgets/header.dart';

import '../widgets/team_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(children: [
      Header(),
      TeamCard(),
    ]));
  }
}
