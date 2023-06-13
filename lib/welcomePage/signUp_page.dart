import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/header.dart';
import 'package:si_proto/welcomePage/signUp_form.dart';
import 'package:si_proto/welcomePage/constants_color.dart';

class signUp_page extends StatelessWidget {
  const signUp_page({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ConstantsColor.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: signUp_form(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
