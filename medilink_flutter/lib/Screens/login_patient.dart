import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LogInPatientScreen extends StatefulWidget {
  const LogInPatientScreen({super.key});

  @override
  _LogInPatientScreenState createState() => _LogInPatientScreenState();
}

class _LogInPatientScreenState extends State<LogInPatientScreen> {
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  Future<void> _requestotp() async {
    final String contact = _contact.text.trim();

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Uri url = Uri.parse('http://localhost:8000/generate_otp/');

    final String jsonData = json.encode({'contact_number': contact});

    final http.Response response =
        await http.post(url, headers: headers, body: jsonData);

    if (response.statusCode == 200) {
      _showSnackbar('OTP requested successfully', ContentType.success);
    } else {
      _showSnackbar(
          'Error requesting OTP: ${response.statusCode}', ContentType.failure);
    }
  }

  Future<void> _submitForm() async {
    final String contact = _contact.text.trim();
    final String otp = _otp.text.trim();

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Uri url = Uri.parse('http://localhost:8000/login_with_otp/');

    final String jsonData =
        json.encode({'contact_number': contact, 'otp': otp});

    final http.Response response =
        await http.post(url, headers: headers, body: jsonData);

    if (response.statusCode == 200) {
      _showSnackbar('Login successful', ContentType.success);
      Navigator.pushReplacementNamed(context, '/homepage');
    } else if (response.statusCode == 404) {
      _showSnackbar('OTP not found', ContentType.failure);
    } else if (response.statusCode == 401) {
      _showSnackbar('Invalid OTP', ContentType.failure);
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
        title: const Text('Patient Log In'),
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
                      'Log In',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _contact,
                      decoration:
                          const InputDecoration(labelText: 'Contact Number'),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _otp,
                      decoration: const InputDecoration(labelText: 'OTP'),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _requestotp,
                      child: const Text('Request OTP'),
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
