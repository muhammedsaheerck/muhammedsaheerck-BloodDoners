import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testfire/Screens/screen_home.dart';
import 'package:testfire/Screens/screen_signin.dart';
import 'package:testfire/Screens/screen_signup.dart';

import 'Screens/screen_doners_add.dart';
import 'Screens/screen_update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "login": (context) => const ScreenSignIn(),
        "signup": (context) => const ScreenSignUp(),
        "/": (context) => const ScreenHome(),
        "add": (context) => const ScreenDonersAdd(),
        "update": (context) => const ScreenUpdateDoner()
      },
      initialRoute: "login",
    );
    // home: ScreenSignIn());
  }
}
