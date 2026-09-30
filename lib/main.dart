import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: const Color(0xFF101218),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BASS THEORY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Teoria musical para contrabaixo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Aprenda tonalidades, graus, escalas, arpejos e linhas de baixo.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            _menuButton(
              context,
              '🎵 Tonalidades',
              '12 tons maiores e 12 menores',
              Icons.music_note,
            ),

            _menuButton(
              context,
              '🎼 Campo Harmônico',
              'Graus, funções e sensações',
              Icons.library_music,
            ),

            _menuButton(
              context,
              '🎸 Braço do Contrabaixo',
              'Notas, graus e posições',
              Icons.music_video,
            ),

            _menuButton(
              context,
              '🎶 Escalas e Modos',
              'Maior, menor e modos gregos',
              Icons.graphic_eq,
            ),

            _menuButton(
              context,
              '🔢 Arpejos e Intervalos',
              'Notas e relações no baixo',
              Icons.multiline_chart,
            ),

            _menuButton(
              context,
              '🎯 Exercícios',
              'Treine seu ouvido e seu instrumento',
              Icons.track_changes,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title será desenvolvido na próxima etapa.'),
            ),
          );
        },
      ),
    );
  }
}
