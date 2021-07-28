import 'package:flutter/material.dart';
// import 'package:healthify_testing/pages/google_sign_in/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthify_testing/bottom_nav_screen.dart';
import 'package:healthify_testing/pages/google_sign_in/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'HKGrotesk',
      ),
      home: SignIn(),
    ),
  );
}
