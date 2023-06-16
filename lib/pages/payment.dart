import 'package:flutter/material.dart';
import 'package:si_proto/models/app_user.dart';

import '../widgets/header.dart';

class Payment extends StatelessWidget {
  const Payment(this.user, {super.key});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:Column(
            children: [
              Header(),
              Text("payment")
            ]
        )
    );
  }
}