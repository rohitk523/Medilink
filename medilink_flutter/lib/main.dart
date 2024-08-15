import 'package:flutter/material.dart';
import 'package:medilink_flutter/Screens/Visit/bp_line_chart.dart';
import 'package:medilink_flutter/Screens/Visit/patient_history.dart';
import 'package:medilink_flutter/Screens/patient/add_patient_data.dart';
import 'package:medilink_flutter/Screens/patient/patient_main_screen.dart';
import 'package:medilink_flutter/Screens/patient/profile_info_patient.dart';
import 'package:medilink_flutter/Screens/patient/signup_login_patient.dart';

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
      onGenerateRoute: (settings) {
        if (settings.name == '/addPatientData') {
          final String username = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return AddPatientDataScreen(username: username);
            },
          );
        }
        // Add other routes if needed
        return null;
      },
      routes: {
        // '/': (context) => const BPChartScreen(),
        '/': (context) => const SignupLoginPatient(),
        '/homepage': (context) => const PatientMainScreen(),
        '/login': (context) => const SignupLoginPatient(),
        '/profile': (context) => const ProfileInfoScreen(),
        '/history': (context) => const PatientHistoryScreen()
      },
    );
  }
}
