import 'package:flutter/material.dart';

import '../widgets/header.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(children: [Header(), Text("payment")]));
  }
}
