import 'package:flutter/material.dart';

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
          ),

          _featureCard(
            context,
            '🎛️ Afinador',
            'Afine seu contrabaixo usando o microfone.',
          ),

          _featureCard(
            context,
            '🎵 Tonalidades',
            '12 tons maiores e 12 tons menores.',
          ),

          _featureCard(
            context,
            '🎼 Campo Harmônico',
            'Graus, funções e sensações musicais.',
          ),

          _featureCard(
            context,
            '🎸 Braço do Contrabaixo',
            'Notas, graus, intervalos e posições.',
          ),

          _featureCard(
            context,
            '🎶 Escalas e Modos',
            'Escalas maiores, menores e modos gregos.',
          ),

          _featureCard(
            context,
            '🔢 Intervalos e Arpejos',
            'Estude as notas dos arpejos.',
          ),

          _featureCard(
            context,
            '👂 Treino de Ouvido',
            'Desenvolva sua percepção musical.',
          ),

          _featureCard(
            context,
            'ℹ️ Sobre o aplicativo',
            'Bass Theory versão 3.0.0',
          ),

          const SizedBox(height: 25),

          const Center(
            child: Text(
              'Bass Theory 3.0.0',
              style: TextStyle(color: Colors.white38),
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
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
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
  if (title.contains('Descobrir')) {
    Navigator.pushNamed(context, '/tom');
  } else if (title.contains('Afinador')) {
    Navigator.pushNamed(context, '/afinador');
  } else if (title.contains('Tonalidades')) {
    Navigator.pushNamed(context, '/tonalidades');
  } else if (title.contains('Campo')) {
    Navigator.pushNamed(context, '/campo');
  } else if (title.contains('Braço')) {
    Navigator.pushNamed(context, '/braco');
  } else if (title.contains('Escalas')) {
    Navigator.pushNamed(context, '/modos');
  } else if (title.contains('Intervalos')) {
    Navigator.pushNamed(context, '/intervalos');
  } else if (title.contains('Ouvido')) {
    Navigator.pushNamed(context, '/ouvido');
  } else if (title.contains('Sobre')) {
    Navigator.pushNamed(context, '/sobre');
  }
},
      ),
    );
  }
}