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
        scaffoldBackgroundColor: const Color(0xFF0D1017),
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
            icon: Icons.mic,
            title: '🎤 Descobrir o Tom',
            subtitle:
                'Cante uma música a capella e descubra o tom provável.',
            page: const KeyDetectorPage(),
          ),

          _featureCard(
            context,
            icon: Icons.tune,
            title: '🎛️ Afinador',
            subtitle:
                'Afine seu contrabaixo usando o microfone do celular.',
            page: const TunerPage(),
          ),

          _featureCard(
            context,
            icon: Icons.music_note,
            title: '🎵 Tonalidades',
            subtitle:
                '12 tons maiores e 12 tons menores.',
            page: const KeysPage(),
          ),

          _featureCard(
            context,
            icon: Icons.library_music,
            title: '🎼 Campo Harmônico',
            subtitle:
                'Graus, funções e sensações musicais.',
            page: const HarmonicFieldPage(),
          ),

          _featureCard(
            context,
            icon: Icons.music_video,
            title: '🎸 Braço do Contrabaixo',
            subtitle:
                'Notas, graus, intervalos e posições.',
            page: const FretboardPage(),
          ),

          _featureCard(
            context,
            icon: Icons.graphic_eq,
            title: '🎶 Escalas e Modos',
            subtitle:
                'Escalas maiores, menores e modos gregos.',
            page: const ModesPage(),
          ),

          _featureCard(
            context,
            icon: Icons.multiline_chart,
            title: '🔢 Intervalos e Arpejos',
            subtitle:
                'Estude as notas que formam os arpejos.',
            page: const IntervalsPage(),
          ),

          _featureCard(
            context,
            icon: Icons.headphones,
            title: '👂 Treino de Ouvido',
            subtitle:
                'Desenvolva sua percepção musical.',
            page: const EarTrainingPage(),
          ),

          _featureCard(
            context,
            icon: Icons.info_outline,
            title: 'ℹ️ Sobre o aplicativo',
            subtitle:
                'Bass Theory versão 3.0.0',
            page: const AboutPage(),
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
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
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
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// DESCOBRIR TOM
// ============================================================

class KeyDetectorPage extends StatelessWidget {
  const KeyDetectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Descobrir o Tom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.mic,
              size: 90,
              color: Colors.blueAccent,
            ),

            const SizedBox(height: 20),

            const Text(
              'Cante uma música a capella',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'O Bass Theory analisará a melodia e tentará encontrar a tonalidade mais provável.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                _showComingSoon(context);
              },
              icon: const Icon(Icons.mic),
              label: const Text(
                'COMEÇAR A OUVIR',
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: const [
                    Text(
                      'Resultado da análise',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Tom provável: —',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Tônica: —',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Maior / menor: —',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Confiança: —',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Depois da análise, o aplicativo mostrará a tonalidade e permitirá visualizar os graus no braço do baixo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Análise pelo microfone será ativada na próxima etapa.',
        ),
      ),
    );
  }
}

// ============================================================
// AFINADOR
// ============================================================

class TunerPage extends StatelessWidget {
  const TunerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎛️ Afinador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'AFINADOR DE CONTRABAIXO',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              '—',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            const Text(
              'Nenhum som detectado',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 35),

            LinearProgressIndicator(
              value: 0.5,
              minHeight: 12,
              borderRadius: BorderRadius.circular(10),
            ),

            const SizedBox(height: 15),

            const Text(
              '0 Hz',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 35),

            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Detector de frequência será ativado na próxima etapa.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.mic),
              label: const Text('ATIVAR MICROFONE'),
            ),

            const SizedBox(height: 30),

            const Text(
              'Afinação padrão',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'E  •  A  •  D  •  G',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TONALIDADES
// ============================================================

class KeysPage extends StatelessWidget {
  const KeysPage({super.key});

  @override
  Widget build(BuildContext context) {
    const keys = [
      'C',
      'C#',
      'D',
      'Eb',
      'E',
      'F',
      'F#',
      'G',
      'Ab',
      'A',
      'Bb',
      'B',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 Tonalidades'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: keys.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: Center(
              child: Text(
                keys[index],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// CAMPO HARMÔNICO
// ============================================================

class HarmonicFieldPage extends StatelessWidget {
  const HarmonicFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    const degrees = [
      ['I', 'Tônica', 'Repouso'],
      ['II', 'Supertônica', 'Preparação'],
      ['III', 'Mediante', 'Cor'],
      ['IV', 'Subdominante', 'Movimento'],
      ['V', 'Dominante', 'Tensão'],
      ['VI', 'Submediante', 'Suavidade'],
      ['VII', 'Sensível', 'Tensão'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎼 Campo Harmônico'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: degrees.map((degree) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(degree[0]),
              ),
              title: Text(
                degree[1],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Sensação: ${degree[2]}',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ============================================================
// BRAÇO DO BAIXO
// ============================================================

class FretboardPage extends StatelessWidget {
  const FretboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const strings = ['E', 'A', 'D', 'G'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎸 Braço do Contrabaixo'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 35),
                  ...List.generate(
                    13,
                    (fret) => SizedBox(
                      width: 60,
                      child: Text(
                        '$fret',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),

              ...strings.map((string) {
                return Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Text(
                        string,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...List.generate(
                      13,
                      (fret) {
                        return Container(
                          width: 58,
                          height: 48,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white24,
                            ),
                          ),
                          child: const Center(
                            child: Text('•'),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// MODOS
// ============================================================

class ModesPage extends StatelessWidget {
  const ModesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const modes = [
      ['Jônio', 'Maior', 'Estável e brilhante'],
      ['Dórico', 'Menor', 'Menor com 6ª maior'],
      ['Frígio', 'Menor', 'Escuro e tenso'],
      ['Lídio', 'Maior', 'Aberto e brilhante'],
      ['Mixolídio', 'Maior', 'Dominante'],
      ['Eólio', 'Menor', 'Melancólico'],
      ['Lócrio', 'Menor', 'Instável e tenso'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎶 Escalas e Modos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: modes.map((mode) {
          return Card(
            child: ListTile(
              title: Text(
                mode[0],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                '${mode[1]} • ${mode[2]}',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ============================================================
// INTERVALOS E ARPEJOS
// ============================================================

class IntervalsPage extends StatelessWidget {
  const IntervalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const intervals = [
      '1ª — Tônica',
      '2ª menor',
      '2ª maior',
      '3ª menor',
      '3ª maior',
      '4ª justa',
      'Trítono',
      '5ª justa',
      '6ª menor',
      '6ª maior',
      '7ª menor',
      '7ª maior',
      '8ª — Oitava',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔢 Intervalos e Arpejos'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: intervals.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(intervals[index]),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// TREINO DE OUVIDO
// ============================================================

class EarTrainingPage extends StatelessWidget {
  const EarTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👂 Treino de Ouvido'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hearing,
                size: 90,
                color: Colors.blueAccent,
              ),

              const SizedBox(height: 20),

              const Text(
                'Desafio de percepção',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Em breve você poderá ouvir uma nota e tentar descobrir qual é.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'COMEÇAR DESAFIO',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SOBRE
// ============================================================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ℹ️ Sobre'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.music_note,
                size: 80,
                color: Colors.blueAccent,
              ),

              SizedBox(height: 20),

              Text(
                'BASS THEORY',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                'Versão 3.0.0',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Teoria musical desenvolvida para contrabaixistas.',
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              Text(
                'Tonalidades • Graus • Escalas • Modos • '
                'Intervalos • Arpejos • Afinador • '
                'Descoberta de tom pela voz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}