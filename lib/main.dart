import 'package:flutter/material.dart';

import 'package:deaf_project/screens/home.dart';

void main() {
  runApp(const DeafApp());
}

class DeafApp extends StatelessWidget {
  const DeafApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deaf Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}
