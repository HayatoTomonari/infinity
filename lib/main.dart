import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_proto/pages/top_page.dart';
import 'package:si_proto/pages/welcome_page.dart';
import 'package:si_proto/utils/constants_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:si_proto/utils/constants_text.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ConstantsText.appTitle,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.bizUDGothicTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: ConstantsColor.kFocusColor),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.hasData) {
            return const TopPage();
          }
          return const WelcomePage();
        },
      ),
    );
  }
}
