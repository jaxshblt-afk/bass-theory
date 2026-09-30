import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/key_detector_page.dart';
import 'screens/tuner_page.dart';
import 'screens/keys_page.dart';
import 'screens/harmonic_field_page.dart';
import 'screens/fretboard_page.dart';
import 'screens/modes_page.dart';
import 'screens/intervals_page.dart';
import 'screens/ear_training_page.dart';
import 'screens/about_page.dart';

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
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1017),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/tom': (_) => const KeyDetectorPage(),
        '/afinador': (_) => const TunerPage(),
        '/tonalidades': (_) => const KeysPage(),
        '/campo': (_) => const HarmonicFieldPage(),
        '/braco': (_) => const FretboardPage(),
        '/modos': (_) => const ModesPage(),
        '/intervalos': (_) => const IntervalsPage(),
        '/ouvido': (_) => const EarTrainingPage(),
        '/sobre': (_) => const AboutPage(),
      },
    );
  }
}