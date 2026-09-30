import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BASS THEORY',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Bass Theory 3.0',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Teoria musical feita para contrabaixistas.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _featureCard(
            context,
            '🎤 Descobrir o Tom',
            'Cante uma música a capella e descubra o tom provável.',
            '/tom',
          ),

          _featureCard(
            context,
            '🎛️ Afinador',
            'Afine seu contrabaixo usando o microfone.',
            '/afinador',
          ),

          _featureCard(
            context,
            '🎵 Tonalidades',
            '12 tons maiores e 12 tons menores.',
            '/tonalidades',
          ),

          _featureCard(
            context,
            '🎼 Campo Harmônico',
            'Graus, funções e sensações musicais.',
            '/campo',
          ),

          _featureCard(
            context,
            '🎸 Braço do Contrabaixo',
            'Notas, graus, intervalos e posições.',
            '/braco',
          ),

          _featureCard(
            context,
            '🎶 Escalas e Modos',
            'Escalas maiores, menores e modos gregos.',
            '/modos',
          ),

          _featureCard(
            context,
            '🔢 Intervalos e Arpejos',
            'Estude as notas dos arpejos.',
            '/intervalos',
          ),

          _featureCard(
            context,
            '👂 Treino de Ouvido',
            'Desenvolva sua percepção musical.',
            '/ouvido',
          ),

          _featureCard(
            context,
            'ℹ️ Sobre o aplicativo',
            'Bass Theory versão 3.0.0',
            '/sobre',
          ),

          const SizedBox(height: 25),

          const Center(
            child: Text(
              'Bass Theory 3.0.0',
              style: TextStyle(
                color: Colors.white38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard(
    BuildContext context,
    String title,
    String subtitle,
    String route,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          _getIcon(title),
          size: 32,
          color: Colors.blueAccent,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            route,
          );
        },
      ),
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Descobrir')) {
      return Icons.mic;
    }

    if (title.contains('Afinador')) {
      return Icons.tune;
    }

    if (title.contains('Tonalidades')) {
      return Icons.music_note;
    }

    if (title.contains('Campo')) {
      return Icons.library_music;
    }

    if (title.contains('Braço')) {
      return Icons.music_video;
    }

    if (title.contains('Escalas')) {
      return Icons.graphic_eq;
    }

    if (title.contains('Intervalos')) {
      return Icons.multiline_chart;
    }

    if (title.contains('Ouvido')) {
      return Icons.headphones;
    }

    return Icons.info_outline;
  }
}