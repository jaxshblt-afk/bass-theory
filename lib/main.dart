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
import 'screens/others_page.dart';

// Conteúdos da seção Outros
import 'others/triads_page.dart';
import 'others/tetrads_page.dart';
import 'others/bass_scales_page.dart';
import 'others/chords_page.dart';
import 'others/bass_lines_page.dart';
import 'others/rhythm_page.dart';
import 'others/techniques_page.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DC Bass Theory',
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

      // Seção Outros
      '/outros': (_) => const OthersPage(),

      '/tetrades': (_) => const TetradsPage(),

      '/triades': (_) => const TriadsPage(),

      '/escalas': (_) => const BassScalesPage(),

      '/acordes': (_) => const ChordsPage(),

      '/linhas': (_) => const BassLinesPage(),

      '/ritmo': (_) => const RhythmPage(),

      '/tecnicas': (_) => const TechniquesPage(),
    },
  ),
);