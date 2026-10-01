import 'package:flutter/material.dart';

class HarmonicFieldPage extends StatefulWidget {
  const HarmonicFieldPage({super.key});

  @override
  State<HarmonicFieldPage> createState() => _HarmonicFieldPageState();
}

class _HarmonicFieldPageState extends State<HarmonicFieldPage> {
  String tonalidadeSelecionada = 'C';

  final List<String> tonalidades = [
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

  final Map<String, List<String>> camposHarmonicos = {
    'C': [
      'C',
      'Dm',
      'Em',
      'F',
      'G',
      'Am',
      'B°',
    ],
    'C#': [
      'C#',
      'D#m',
      'Fm',
      'F#',
      'G#',
      'A#m',
      'C°',
    ],
    'D': [
      'D',
      'Em',
      'F#m',
      'G',
      'A',
      'Bm',
      'C#°',
    ],
    'Eb': [
      'Eb',
      'Fm',
      'Gm',
      'Ab',
      'Bb',
      'Cm',
      'D°',
    ],
    'E': [
      'E',
      'F#m',
      'G#m',
      'A',
      'B',
      'C#m',
      'D#°',
    ],
    'F': [
      'F',
      'Gm',
      'Am',
      'Bb',
      'C',
      'Dm',
      'E°',
    ],
    'F#': [
      'F#',
      'G#m',
      'A#m',
      'B',
      'C#',
      'D#m',
      'E#°',
    ],
    'G': [
      'G',
      'Am',
      'Bm',
      'C',
      'D',
      'Em',
      'F#°',
    ],
    'Ab': [
      'Ab',
      'Bbm',
      'Cm',
      'Db',
      'Eb',
      'Fm',
      'G°',
    ],
    'A': [
      'A',
      'Bm',
      'C#m',
      'D',
      'E',
      'F#m',
      'G#°',
    ],
    'Bb': [
      'Bb',
      'Cm',
      'Dm',
      'Eb',
      'F',
      'Gm',
      'A°',
    ],
    'B': [
      'B',
      'C#m',
      'D#m',
      'E',
      'F#',
      'G#m',
      'A#°',
    ],
  };

  final List<String> graus = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
  ];

  final List<String> nomes = [
    'Tônica',
    'Supertônica',
    'Mediante',
    'Subdominante',
    'Dominante',
    'Submediante',
    'Sensível',
  ];

  final List<String> funcoes = [
    'Tônica',
    'Pré-dominante',
    'Tônica',
    'Subdominante',
    'Dominante',
    'Tônica',
    'Dominante',
  ];

  final List<String> sensacoes = [
    'Repouso',
    'Preparação',
    'Cor',
    'Movimento',
    'Tensão',
    'Suavidade',
    'Forte tensão',
  ];

  @override
  Widget build(BuildContext context) {
    final acordes = camposHarmonicos[tonalidadeSelecionada]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎼 Campo Harmônico'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'CAMPO HARMÔNICO MAIOR',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Escolha uma tonalidade para visualizar seus acordes.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tonalidade',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    value: tonalidadeSelecionada,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.music_note),
                    ),
                    items: tonalidades.map((tom) {
                      return DropdownMenuItem(
                        value: tom,
                        child: Text(
                          '$tom maior',
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (valor) {
                      if (valor == null) return;

                      setState(() {
                        tonalidadeSelecionada = valor;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Text(
                    'Campo Harmônico de',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '$tonalidadeSelecionada maior',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    acordes.join('  •  '),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          ...List.generate(7, (index) {
            final acorde = acordes[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    graus[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      acorde,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        nomes[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Função: ${funcoes[index]}  •  ${sensacoes[index]}',
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 10),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📚 Fórmula do campo maior',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'I  •  II  •  III  •  IV  •  V  •  VI  •  VII',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Maior  •  menor  •  menor  •  Maior  •  Maior  •  menor  •  diminuto',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
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