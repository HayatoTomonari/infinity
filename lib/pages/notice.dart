import 'package:flutter/material.dart';
import 'package:si_proto/models/app_user.dart';

import '../widgets/header.dart';

class Notice extends StatelessWidget {
  const Notice(this.user, {super.key});
  final AppUser user;

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
