import 'package:flutter/material.dart';

class TetradFretboardPage extends StatelessWidget {
  final String nome;
  final String cifra;
  final List<String> notasTetrade;

  const TetradFretboardPage({
    super.key,
    required this.nome,
    required this.cifra,
    required this.notasTetrade,
  });

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

  static const List<String> cordas = [
    'E',
    'A',
    'D',
    'G',
  ];

  static const Map<String, int> afinacao = {
    'E': 4,
    'A': 9,
    'D': 2,
    'G': 7,
  };

  String notaNaCasa(String corda, int casa) {
    final inicio = afinacao[corda]!;
    return notas[(inicio + casa) % 12];
  }

  bool fazParteDaTetrade(String nota) {
    return notasTetrade.contains(nota);
  }

  bool ehTonica(String nota) {
    return notasTetrade.isNotEmpty &&
        nota == notasTetrade.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🎸 $cifra'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                nome,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                cifra,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Notas: ${notasTetrade.join(' • ')}',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _legenda(
                        Colors.blueAccent,
                        'Tônica',
                      ),
                      const SizedBox(width: 18),
                      _legenda(
                        Colors.orangeAccent,
                        'Tétrade',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _construirBraco(),

              const SizedBox(height: 20),

              const Text(
                'As notas destacadas mostram onde você pode tocar as notas da tétrade no braço.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legenda(Color cor, String texto) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        Text(texto),
      ],
    );
  }

  Widget _construirBraco() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF68432B),
              Color(0xFF3E2518),
              Color(0xFF68432B),
            ],
          ),
        ),
        child: Column(
          children: [
            _cabecalho(),

            ...cordas.map(
              (corda) => _construirCorda(corda),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cabecalho() {
    return Row(
      children: [
        Container(
          width: 45,
          height: 32,
        ),

        ...List.generate(
          25,
          (casa) => Container(
            width: 58,
            height: 32,
            alignment: Alignment.center,
            child: Text(
              '$casa',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _construirCorda(String corda) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 64,
          alignment: Alignment.center,
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
          25,
          (casa) {
            final nota =
                notaNaCasa(corda, casa);

            final pertence =
                fazParteDaTetrade(nota);

            final tonica =
                ehTonica(nota);

            return Container(
              width: 58,
              height: 64,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.white54,
                    width: casa == 0 ? 4 : 2,
                  ),
                  bottom: const BorderSide(
                    color: Colors.black54,
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (pertence)
                    Container(
                      width: tonica ? 42 : 38,
                      height: tonica ? 42 : 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tonica
                            ? Colors.blueAccent
                            : Colors.orangeAccent,
                        boxShadow: [
                          BoxShadow(
                            color: (tonica
                                    ? Colors.blueAccent
                                    : Colors.orangeAccent)
                                .withOpacity(0.45),
                            blurRadius: 9,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          nota,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                  Positioned(
                    right: 2,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: _espessuraCorda(corda),
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  double _espessuraCorda(String corda) {
    switch (corda) {
      case 'E':
        return 5;
      case 'A':
        return 4;
      case 'D':
        return 3;
      case 'G':
        return 2;
      default:
        return 3;
    }
  }
}