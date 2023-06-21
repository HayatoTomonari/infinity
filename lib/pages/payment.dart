import 'package:flutter/material.dart';

import '../widgets/header_widget.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(children: [HeaderWidget(), Text("payment")]));
  }
}
