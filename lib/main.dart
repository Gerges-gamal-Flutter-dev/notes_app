import 'package:flutter/material.dart';
import 'package:flutter_sqflite_app/models/Splash_Screen.dart';
import 'package:flutter_sqflite_app/models/add_notes.dart';
import 'package:flutter_sqflite_app/models/edit_notes.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      routes: {
       '/add': (context) => const AddNotes(),
       '/edit': (context) => const EditNotes(),
      },
    );
  }
}
