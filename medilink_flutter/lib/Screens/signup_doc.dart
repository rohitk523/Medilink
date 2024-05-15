import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupDocScreen extends StatefulWidget {
  const SignupDocScreen({Key? key}) : super(key: key);

  @override
  _SignupDocScreenState createState() => _SignupDocScreenState();
}

class _SignupDocScreenState extends State<SignupDocScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Uri url = Uri.parse('http://localhost:8000/signup_doc');

    final String jsonData =
        json.encode({'username': username, 'password': password});

    final http.Response response =
        await http.post(url, headers: headers, body: jsonData);

    if (response.statusCode == 200) {
      print('User added successfully');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Doctor'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Flexible(
            //   flex: 1,
            //   child: Image.asset(
            //     'images/niggatron.png', // Replace with your image path
            //     width: 200,
            //     height: 200,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // const SizedBox(width: 20),
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
