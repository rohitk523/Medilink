import 'package:flutter/material.dart';
import 'package:medilink_flutter/Screens/hompage.dart';
import 'package:medilink_flutter/Screens/signup_doc.dart';
import 'package:medilink_flutter/Screens/login_patient.dart';
import 'package:medilink_flutter/Screens/signup_login_patient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D A S H B O A R D UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/signup_login_patient': (context) => const SignupLoginPatient(),
        // '/homepage': (context) => const HomePage()
      },
    );
  }
}
