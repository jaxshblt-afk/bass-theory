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
        useMaterial3: true,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const HomePage(),

        '/tom': (context) => const KeyDetectorPage(),

        '/afinador': (context) => const TunerPage(),

        '/tonalidades': (context) => const KeysPage(),

        '/campo': (context) => const HarmonicFieldPage(),

        '/braco': (context) => const FretboardPage(),

        '/modos': (context) => const ModesPage(),

        '/intervalos': (context) => const IntervalsPage(),

        '/ouvido': (context) => const EarTrainingPage(),

        '/sobre': (context) => const AboutPage(),
      },
    );
  }
}