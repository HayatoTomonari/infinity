import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お知らせ'),
      ),
      body:
          const Center(child: Text('お知らせ画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}
