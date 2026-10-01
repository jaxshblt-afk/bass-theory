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

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Bass Theory',
    theme: ThemeData.dark(),

    routes: {
      '/': (_) => const HomePage(),
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
  ),
);