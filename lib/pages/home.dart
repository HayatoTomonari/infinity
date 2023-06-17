import 'package:flutter/material.dart';
import 'package:si_proto/models/app_user.dart';
import 'package:si_proto/widgets/header.dart';

import '../models/team.dart';
import '../widgets/team_assets.dart';

class Home extends StatelessWidget {
  const Home(this.user, this.team, {super.key});
  final AppUser user;
  final Team team;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Header(),
          TeamAssets(user, team),
    ]));
  }
}
