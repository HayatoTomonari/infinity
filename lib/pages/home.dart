import 'package:flutter/material.dart';
import 'package:si_proto/models/app_user.dart';

class Home extends StatelessWidget {
  const Home(this.user, {super.key});
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
      body:Column(
          children: [
            Center(
              child: Container(
                height:250,
                width:double.infinity,
                margin: const EdgeInsets.all(50),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      colors: [
                        Colors.purple,
                        Colors.purpleAccent,
                      ]
                  ),
                ),
                child: Text(user.userName),
              ),
            ),
          ]
      )
    );
  }
}
