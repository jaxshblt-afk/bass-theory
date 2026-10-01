import 'package:flutter/material.dart';

class IntervalsPage extends StatelessWidget {
  const IntervalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const intervals = [
      {
        'nome': '1ª — Tônica',
        'semitons': '0 semitons',
        'exemplo': 'C → C',
        'descricao': 'É a nota fundamental e o ponto de repouso.',
      },
      {
        'nome': '2ª menor',
        'semitons': '1 semitom',
        'exemplo': 'C → Db',
        'descricao': 'Intervalo curto com forte sensação de tensão.',
      },
      {
        'nome': '2ª maior',
        'semitons': '2 semitons',
        'exemplo': 'C → D',
        'descricao': 'Movimento de um tom entre duas notas.',
      },
      {
        'nome': '3ª menor',
        'semitons': '3 semitons',
        'exemplo': 'C → Eb',
        'descricao': 'Define a sonoridade menor.',
      },
      {
        'nome': '3ª maior',
        'semitons': '4 semitons',
        'exemplo': 'C → E',
        'descricao': 'Define a sonoridade maior.',
      },
      {
        'nome': '4ª justa',
        'semitons': '5 semitons',
        'exemplo': 'C → F',
        'descricao': 'Intervalo muito usado em linhas de baixo.',
      },
      {
        'nome': 'Trítono',
        'semitons': '6 semitons',
        'exemplo': 'C → F#',
        'descricao': 'Intervalo de grande tensão sonora.',
      },
      {
        'nome': '5ª justa',
        'semitons': '7 semitons',
        'exemplo': 'C → G',
        'descricao': 'Intervalo forte e muito utilizado no contrabaixo.',
      },
      {
        'nome': '6ª menor',
        'semitons': '8 semitons',
        'exemplo': 'C → Ab',
        'descricao': 'Tem uma sonoridade característica e expressiva.',
      },
      {
        'nome': '6ª maior',
        'semitons': '9 semitons',
        'exemplo': 'C → A',
        'descricao': 'Intervalo aberto e bastante musical.',
      },
      {
        'nome': '7ª menor',
        'semitons': '10 semitons',
        'exemplo': 'C → Bb',
        'descricao': 'Muito importante nos acordes dominantes.',
      },
      {
        'nome': '7ª maior',
        'semitons': '11 semitons',
        'exemplo': 'C → B',
        'descricao': 'Cria uma forte tendência de resolução.',
      },
      {
        'nome': '8ª — Oitava',
        'semitons': '12 semitons',
        'exemplo': 'C → C',
        'descricao': 'A mesma nota em uma região mais aguda.',
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
            'Aprenda a distância entre duas notas e como ela soa.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 20),

          ...intervals.map((interval) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      interval['nome']!,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      interval['semitons']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Exemplo: ${interval['exemplo']}',
                    ),

                    const SizedBox(height: 8),

                    Text(
                      interval['descricao']!,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 15),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '🎼 ARPEJOS',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Arpejo maior',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    '1  •  3  •  5',
                    style: TextStyle(fontSize: 17),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Arpejo menor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    '1  •  b3  •  5',
                    style: TextStyle(fontSize: 17),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Arpejo dominante',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    '1  •  3  •  5  •  b7',
                    style: TextStyle(fontSize: 17),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Arpejo diminuto',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    '1  •  b3  •  b5  •  bb7',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}