import 'package:flutter/material.dart';

import '../widgets/header_widget.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(children: [HeaderWidget(), Text("payment")]));
  }
}
