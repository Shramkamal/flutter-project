import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/auth/main_page.dart';
import 'package:flutter_todo_list/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      print("Initializing Firebase...");
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Firebase initialized successfully!");
    } else {
      print("Firebase is already initialized!");
    }
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(const MyApp());
}

void testFirebase() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Add test data
  await firestore.collection('test').add({
    'timestamp': DateTime.now(),
    'message': 'Hello from Flutter Web!',
  });
  print('Data added to Firebase!');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main_Page(),
    );
  }
}
