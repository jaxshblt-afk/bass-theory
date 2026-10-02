import 'package:flutter/material.dart';

import 'interval_fretboard_page.dart';

class IntervalsPage extends StatelessWidget {
  const IntervalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const intervals = [
      {
        'nome': '1ª — Tônica',
        'semitons': 0,
        'exemplo': 'C → C',
        'descricao': 'Nota fundamental e ponto de repouso.',
      },
      {
        'nome': '2ª menor',
        'semitons': 1,
        'exemplo': 'C → Db',
        'descricao': 'Intervalo curto com forte tensão.',
      },
      {
        'nome': '2ª maior',
        'semitons': 2,
        'exemplo': 'C → D',
        'descricao': 'Movimento de um tom.',
      },
      {
        'nome': '3ª menor',
        'semitons': 3,
        'exemplo': 'C → Eb',
        'descricao': 'Define a sonoridade menor.',
      },
      {
        'nome': '3ª maior',
        'semitons': 4,
        'exemplo': 'C → E',
        'descricao': 'Define a sonoridade maior.',
      },
      {
        'nome': '4ª justa',
        'semitons': 5,
        'exemplo': 'C → F',
        'descricao': 'Muito usada em linhas de baixo.',
      },
      {
        'nome': 'Trítono',
        'semitons': 6,
        'exemplo': 'C → F#',
        'descricao': 'Intervalo de grande tensão.',
      },
      {
        'nome': '5ª justa',
        'semitons': 7,
        'exemplo': 'C → G',
        'descricao': 'Muito utilizada no contrabaixo.',
      },
      {
        'nome': '6ª menor',
        'semitons': 8,
        'exemplo': 'C → Ab',
        'descricao': 'Sonoridade expressiva.',
      },
      {
        'nome': '6ª maior',
        'semitons': 9,
        'exemplo': 'C → A',
        'descricao': 'Intervalo aberto e musical.',
      },
      {
        'nome': '7ª menor',
        'semitons': 10,
        'exemplo': 'C → Bb',
        'descricao': 'Muito importante nos acordes dominantes.',
      },
      {
        'nome': '7ª maior',
        'semitons': 11,
        'exemplo': 'C → B',
        'descricao': 'Cria forte tendência de resolução.',
      },
      {
        'nome': '8ª — Oitava',
        'semitons': 12,
        'exemplo': 'C → C',
        'descricao': 'A mesma nota em região mais aguda.',
      },
    ];

    const arpejos = [
      {
        'nome': 'Arpejo maior',
        'formula': '1 • 3 • 5',
        'semitons': [0, 4, 7],
      },
      {
        'nome': 'Arpejo menor',
        'formula': '1 • b3 • 5',
        'semitons': [0, 3, 7],
      },
      {
        'nome': 'Arpejo dominante',
        'formula': '1 • 3 • 5 • b7',
        'semitons': [0, 4, 7, 10],
      },
      {
        'nome': 'Arpejo diminuto',
        'formula': '1 • b3 • b5 • bb7',
        'semitons': [0, 3, 6, 9],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔢 Intervalos e Arpejos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'INTERVALOS MUSICAIS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Toque em um intervalo para visualizar no braço do contrabaixo.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 20),

          ...intervals.map((interval) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IntervalFretboardPage(
                        titulo: interval['nome'] as String,
                        semitons: interval['semitons'] as int,
                        formula: interval['exemplo'] as String,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.music_note,
                        color: Colors.blueAccent,
                        size: 30,
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              interval['nome'] as String,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              '${interval['semitons']} semitons',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              interval['descricao'] as String,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          const Text(
            '🎼 ARPEJOS',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Toque em um arpejo para ver as notas no braço.',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 15),

          ...arpejos.map((arpejo) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IntervalFretboardPage(
                        titulo: arpejo['nome'] as String,
                        semitons:
                            arpejo['semitons'] as List<int>,
                        formula: arpejo['formula'] as String,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.queue_music,
                        color: Colors.blueAccent,
                        size: 30,
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              arpejo['nome'] as String,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),

                            const SizedBox(height: 7),

                            Text(
                              arpejo['formula'] as String,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}