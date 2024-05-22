import 'package:flutter/material.dart';
import 'package:medilink_flutter/Screens/login_patient.dart';
import 'package:medilink_flutter/Screens/signup_patient';

class SignupLoginPatient extends StatefulWidget {
  const SignupLoginPatient({super.key});

  @override
  State<SignupLoginPatient> createState() => _SignupLoginPatientState();
}

class _SignupLoginPatientState extends State<SignupLoginPatient> {
  bool _isSignUp = true; // Initially set to true for signup

  // Method to toggle between signup and login
  void toggleSignupLogin() {
    setState(() {
      _isSignUp = !_isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignUp ? 'Signup' : 'Login'), // Displaying dynamic title
      ),
      body: Center(
        child: _isSignUp
            ? const SignupPatientScreen()
            : const LogInPatientScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleSignupLogin,
        tooltip: _isSignUp ? 'Switch to Login' : 'Switch to Signup',
        child: Icon(_isSignUp ? Icons.login : Icons.person_add),
      ),
    );
  }
}
