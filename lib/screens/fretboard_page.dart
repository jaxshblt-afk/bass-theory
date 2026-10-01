import 'package:flutter/material.dart';

class FretboardPage extends StatelessWidget {
  const FretboardPage({super.key});

  static const List<String> notas = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B',
  ];

  String notaNaCasa(String corda, int casa) {
    const afinacao = {
      'E': 4,
      'A': 9,
      'D': 2,
      'G': 7,
    };

    final inicio = afinacao[corda]!;
    return notas[(inicio + casa) % 12];
  }

  @override
  Widget build(BuildContext context) {
    const cordas = ['E', 'A', 'D', 'G'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎸 Braço do Contrabaixo'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BRAÇO DO CONTRABAIXO',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Afinação padrão: E • A • D • G',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const SizedBox(width: 40),
                  ...List.generate(
                    13,
                    (casa) => SizedBox(
                      width: 64,
                      child: Text(
                        '$casa',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              ...cordas.map(
                (corda) => Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        corda,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    ...List.generate(
                      13,
                      (casa) {
                        final nota = notaNaCasa(corda, casa);
                        final ehTonica = nota == 'C';

                        return Container(
                          width: 64,
                          height: 52,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: ehTonica
                                ? Colors.blueAccent.withOpacity(0.35)
                                : null,
                            border: Border.all(
                              color: Colors.white24,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              nota,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ehTonica
                                    ? Colors.blueAccent
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                '🔵 Tônica: C',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'As notas destacadas mostram onde está a tônica C no braço.',
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