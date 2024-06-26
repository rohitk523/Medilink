import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SignupPatientScreen extends StatefulWidget {
  const SignupPatientScreen({Key? key}) : super(key: key);

  @override
  _SignupPatientScreenState createState() => _SignupPatientScreenState();
}

class _SignupPatientScreenState extends State<SignupPatientScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  Future<void> _submitForm() async {
    final String name = _nameController.text.trim();
    final String contact = _contactController.text.trim();
    final int age = int.tryParse(_ageController.text.trim()) ??
        0; // Handle age input as integer
    final String city = _cityController.text.trim();

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Uri url = Uri.parse('http://localhost:8000/signup_patient');

    final String jsonData = json.encode({
      'name': name,
      'contact': contact,
      'age': age,
      'city': city,
    });

    final http.Response response =
        await http.post(url, headers: headers, body: jsonData);

    if (response.statusCode == 200) {
      _showSnackbar('Patient added successfully', ContentType.success);
      Navigator.pushReplacementNamed(context, '/homepage');
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
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _contactController,
                      decoration: const InputDecoration(labelText: 'Contact'),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Age'),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _cityController,
                      decoration: const InputDecoration(labelText: 'City'),
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
