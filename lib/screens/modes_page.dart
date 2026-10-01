import 'package:flutter/material.dart';

class ModesPage extends StatelessWidget {
  const ModesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const modes = [
      {
        'nome': 'Jônio',
        'tipo': 'Maior',
        'graus': '1  2  3  4  5  6  7',
        'intervalos': 'T  2  3  4  5  6  7',
        'descricao': 'É a escala maior natural. Som estável, aberto e brilhante.',
      },
      {
        'nome': 'Dórico',
        'tipo': 'Menor',
        'graus': '1  2  b3  4  5  6  b7',
        'intervalos': 'T  2  b3  4  5  6  b7',
        'descricao': 'Modo menor com 6ª maior. Muito usado em grooves e funk.',
      },
      {
        'nome': 'Frígio',
        'tipo': 'Menor',
        'graus': '1  b2  b3  4  5  b6  b7',
        'intervalos': 'T  b2  b3  4  5  b6  b7',
        'descricao': 'Tem a 2ª menor e produz uma sonoridade escura e tensa.',
      },
      {
        'nome': 'Lídio',
        'tipo': 'Maior',
        'graus': '1  2  3  #4  5  6  7',
        'intervalos': 'T  2  3  #4  5  6  7',
        'descricao': 'Escala maior com 4ª aumentada. Som aberto e brilhante.',
      },
      {
        'nome': 'Mixolídio',
        'tipo': 'Maior',
        'graus': '1  2  3  4  5  6  b7',
        'intervalos': 'T  2  3  4  5  6  b7',
        'descricao': 'Escala maior com 7ª menor. Muito usada sobre acordes dominantes.',
      },
      {
        'nome': 'Eólio',
        'tipo': 'Menor',
        'graus': '1  2  b3  4  5  b6  b7',
        'intervalos': 'T  2  b3  4  5  b6  b7',
        'descricao': 'É a escala menor natural, com sonoridade melancólica.',
      },
      {
        'nome': 'Lócrio',
        'tipo': 'Menor',
        'graus': '1  b2  b3  4  b5  b6  b7',
        'intervalos': 'T  b2  b3  4  b5  b6  b7',
        'descricao': 'Possui 5ª diminuta e apresenta uma sonoridade instável e tensa.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎶 Escalas e Modos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'ESCALAS E MODOS GREGOS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Estude os sete modos derivados da escala maior.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 20),

          ...modes.map((mode) {
            return Card(
              margin: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(Icons.music_note),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            mode['nome']!,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),

                        Text(
                          mode['tipo']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      mode['descricao']!,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Graus',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      mode['graus']!,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Intervalos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      mode['intervalos']!,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
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
                children: const [
                  Text(
                    '📚 Dica para o baixista',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Estude primeiro a nota fundamental de cada modo. '
                    'Depois pratique a escala lentamente no braço do '
                    'contrabaixo e procure perceber a característica '
                    'sonora de cada modo.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
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