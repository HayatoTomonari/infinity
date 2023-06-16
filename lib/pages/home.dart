import 'package:flutter/material.dart';
import 'package:si_proto/models/app_user.dart';
import 'package:si_proto/widgets/header.dart';

class Home extends StatelessWidget {
  const Home(this.user, {super.key});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
          children: [
            const Header(),
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
                        Colors.deepPurple,
                        Colors.pink,
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
