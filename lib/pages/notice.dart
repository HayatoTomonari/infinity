import 'package:flutter/material.dart';
import 'package:si_proto/models/app_user.dart';
import 'package:si_proto/models/team.dart';

import '../widgets/header.dart';

class Notice extends StatelessWidget {
  const Notice(this.user, this.team, {super.key});
  final AppUser user;
  final Team team;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:Column(
            children: [
              Header(),
              Text("notice")
            ]
        )
    );
  }
}
