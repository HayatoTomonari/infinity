import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('入金'),
      ),
      body: const Center(
          child: Text('入金', style: TextStyle(fontSize: 32.0))),
    );
  }
}