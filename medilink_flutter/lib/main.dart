import 'package:flutter/material.dart';
import 'package:medilink_flutter/Screens/main_screen.dart';
import 'package:medilink_flutter/Screens/profile_info_patient.dart';
import 'package:medilink_flutter/Screens/signup_login_patient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/': (context) => const SignupLoginPatient(),
        '/homepage': (context) => const MainScreen(),
        '/login': (context) => const SignupLoginPatient(),
        '/profile': (context) => const ProfileInfoScreen(),
      },
    );
  }
}
