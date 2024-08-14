import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:medilink_flutter/Screens/patient/add_patient_data.dart';

class SignupPatientScreen extends StatefulWidget {
  const SignupPatientScreen({Key? key}) : super(key: key);

  @override
  _SignupPatientScreenState createState() => _SignupPatientScreenState();
}

class _SignupPatientScreenState extends State<SignupPatientScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _submitForm() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    // Check if password and confirm password match
    if (password != confirmPassword) {
      _showSnackbar('Passwords do not match', ContentType.failure);
      return;
    }

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Uri url = Uri.parse('http://localhost:8000/signup_patient');

    final String jsonData = json.encode({
      'username': username,
      'password': password,
      'confirm_password': confirmPassword,
    });

    final http.Response response =
        await http.post(url, headers: headers, body: jsonData);

    if (response.statusCode == 200) {
      _showSnackbar('Patient signed up successfully', ContentType.success);
      Navigator.pushNamed(
        context,
        '/addPatientData',
        arguments: username, // Pass the username
      );
    } else {
      _showSnackbar('Error: ${response.statusCode}', ContentType.failure);
    }
  }

  void _showSnackbar(String message, ContentType contentType) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: contentType == ContentType.success ? 'Success!' : 'Error!',
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Patient'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Signup',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Signup'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
