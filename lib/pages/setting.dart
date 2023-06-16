import 'package:flutter/material.dart';
import 'package:si_proto/models/team.dart';

import '../models/app_user.dart';
import '../widgets/header.dart';

class Setting extends StatelessWidget {
  const Setting(this.user, this.team, {super.key});
  final AppUser user;
  final Team team;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:Column(
            children: [
              Header(),
              Text("setting")
            ]
        )
    );
  }
}