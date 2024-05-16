import 'package:flutter/material.dart';
import 'package:medilink_flutter/Screens/signup_doc.dart';
import 'package:medilink_flutter/Screens/signup_patient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignupDocScreen(),
        '/signup_patient': (context) => const SignupPatientScreen()
      },
    );
  }
}
