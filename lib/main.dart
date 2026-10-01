import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const BassTheoryApp());
}

class BassTheoryApp extends StatelessWidget {
  const BassTheoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bass Theory',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}