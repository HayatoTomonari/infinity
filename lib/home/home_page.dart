import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/header.dart';
import 'package:si_proto/welcomePage/constants_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ConstantsColor.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
            ],
          ),
        ),
      ),
    );
  }
}