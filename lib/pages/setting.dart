import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../widgets/header.dart';

class Setting extends StatelessWidget {
  const Setting(this.user, {super.key});
  final AppUser user;

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