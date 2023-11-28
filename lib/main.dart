import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAVHlheS9m9J0nsRpUORtCGgv0ZtPRzwM4",
      authDomain: "firestore-read-772c2.firebaseapp.com",
      projectId: "firestore-read-772c2",
      storageBucket: "firestore-read-772c2.appspot.com",
      messagingSenderId: "808069210604",
      appId: "1:808069210604:web:29a00394c606c57be460c9",
      measurementId: "G-CJGN6BMQ56",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String message = ''; // Variable to store the message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data Write '),
        backgroundColor:
            Color.fromARGB(255, 33, 184, 243), // Change the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(
                        255, 215, 33, 243)), // Change the label color
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 155, 238, 0)), // Change the label color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                writeData(usernameController.text, emailController.text);
              },
              child: Text(
                'Write',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 8, 241, 183)), // Change the button text color
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 253, 1, 1), // Change the button background color
              ),
            ),
            SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(
                color: Color.fromARGB(
                    255, 36, 2, 104), // Change the message text color
                fontWeight: FontWeight.bold,
              ),
            ), // Display the message
          ],
        ),
      ),
    );
  }

  Future<void> writeData(String username, String email) async {
    try {
      await users.add({
        'username': username,
        'email': email,
        // Add more fields as needed
      });
      // Set success message
      setMessage('Data written successfully');
    } catch (e) {
      // Set error message
      setMessage('Error writing data: $e');
    }
  }

  void setMessage(String value) {
    setState(() {
      message = value;
    });
  }
}
