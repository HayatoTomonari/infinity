import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/welcomePage.dart';
import 'package:si_proto/welcomePage/ConstantsColor.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'future',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ConstantsColor.kAccentColor),
      ),
      home: const WelcomePage(),
    );
  }
}