import 'package:flutter/material.dart';
import 'package:medilink_flutter/Screens/doctor/signup_doc.dart';
import 'package:medilink_flutter/Screens/doctor/login_doc.dart';

class SignupLoginDoc extends StatefulWidget {
  const SignupLoginDoc({Key? key}) : super(key: key);

  @override
  _SignupLoginDocState createState() => _SignupLoginDocState();
}

class _SignupLoginDocState extends State<SignupLoginDoc> {
  bool _isSignUp = false; // Initially set to true for signup

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
        child: _isSignUp ? const SignupDocScreen() : const LoginDocScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleSignupLogin,
        tooltip: _isSignUp ? 'Switch to Login' : 'Switch to Signup',
        child: Icon(_isSignUp ? Icons.login : Icons.person_add),
      ),
    );
  }
}
