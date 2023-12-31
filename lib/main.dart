import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/pages/top/top_page.dart';
import 'package:si_proto/pages/signin/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:si_proto/utils/constants_text.dart';
import 'firebase/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting('ja_JP').then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ConstantsText.appTitle,
      theme: ThemeData(fontFamily: 'NotoSansJP'),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.hasData) {
            return const TopPage();
          }
          return const SignInPage();
        },
      ),
    );
  }
}
