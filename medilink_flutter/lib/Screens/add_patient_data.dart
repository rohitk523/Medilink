import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class AddPatientDataScreen extends StatefulWidget {
  final String username; // Receive the username from the previous screen

  const AddPatientDataScreen({Key? key, required this.username})
      : super(key: key);

  @override
  _AddPatientDataScreenState createState() => _AddPatientDataScreenState();
}

class _AddPatientDataScreenState extends State<AddPatientDataScreen> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  Future<void> _submitData() async {
    final String dob = _dobController.text.trim();
    final String height = _heightController.text.trim();
    final String weight = _weightController.text.trim();

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Uri url =
        Uri.parse('http://localhost:8000/add_patient_data/${widget.username}');

    final String jsonData = json.encode({
      'dob': dob.isEmpty ? null : dob,
      'height': height.isEmpty ? null : height,
      'weight': weight.isEmpty ? null : weight,
    });

    final http.Response response =
        await http.post(url, headers: headers, body: jsonData);

    if (response.statusCode == 200) {
      _showSnackbar('Patient data added successfully', ContentType.success);
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
        title: const Text('Add Patient Data'),
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
                      'Add Additional Information',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _dobController,
                      decoration:
                          const InputDecoration(labelText: 'Date of Birth'),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _heightController,
                      decoration: const InputDecoration(labelText: 'Height'),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: _weightController,
                      decoration: const InputDecoration(labelText: 'Weight'),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitData,
                      child: const Text('Submit'),
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
