import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home(this.uid, {super.key});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('future',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body:
          const Center(child: Text('ホーム画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}
