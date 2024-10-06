
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_app/models/home_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          // ignore: use_build_context_synchronously
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assetes/لقطة شاشة 2024-10-04 210650.png"),
          const CircularProgressIndicator(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}