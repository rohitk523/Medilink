import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogInPatientScreen extends StatefulWidget {
  const LogInPatientScreen({Key? key}) : super(key: key);

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
      print('OTP requested successfully');
      // Optionally, you can show a message to the user that OTP has been sent
    } else {
      print('Error requesting OTP: ${response.statusCode}');
      // Handle error, such as displaying an error message to the user
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
      print(
          'Login successful'); // Assuming the backend returns a 200 status code for successful login
      Navigator.pushReplacementNamed(context, '/homepage');
    } else if (response.statusCode == 404) {
      print('OTP not found'); // Handle OTP not found error
    } else if (response.statusCode == 401) {
      print('Invalid OTP'); // Handle invalid OTP error
    } else {
      print('Error: ${response.statusCode}');
      // Handle other errors, such as displaying an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Patient'),
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
                      controller: _contact,
                      decoration: const InputDecoration(labelText: 'Contact'),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _otp,
                      decoration: const InputDecoration(labelText: 'OTP'),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _requestotp,
                      child: const Text('Request OTP'),
                    ),
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
