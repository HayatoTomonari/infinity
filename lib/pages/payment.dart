import 'package:flutter/material.dart';
import 'package:si_proto/models/app_user.dart';

class Payment extends StatelessWidget {
  const Payment(this.user, {super.key});
  final AppUser user;

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
      body: const Center(
          child: Text('入金', style: TextStyle(fontSize: 32.0))),
    );
  }
}