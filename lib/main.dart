import 'package:flutter/material.dart';
import 'package:trackbuddy/screens/login.dart';
import 'package:trackbuddy/widgets/bottomNav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'track buddy',
      //home: BottomNav(),
      home: Login(),
    );
  }
}


