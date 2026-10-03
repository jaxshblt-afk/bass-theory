import 'package:flutter/material.dart';

class FretboardPage extends StatefulWidget {
  const FretboardPage({super.key});

  @override
  State<FretboardPage> createState() => _FretboardPageState();
}

class _FretboardPageState extends State<FretboardPage> {
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

  String notaSelecionada = 'C';
  String cordaSelecionada = 'E';
  int casaSelecionada = 0;

  String notaNaCasa(String corda, int casa) {
    final inicio = afinacao[corda]!;
    return notas[(inicio + casa) % 12];
  }

  bool ehMarcador(int casa) {
    return casa == 3 ||
        casa == 5 ||
        casa == 7 ||
        casa == 9 ||
        casa == 12 ||
        casa == 15 ||
        casa == 17 ||
        casa == 19 ||
        casa == 21 ||
        casa == 24;
  }

  bool ehMarcadorDuplo(int casa) {
    return casa == 12 || casa == 24;
  }

  void selecionarNota(
    String corda,
    int casa,
    String nota,
  ) {
    setState(() {
      cordaSelecionada = corda;
      casaSelecionada = casa;
      notaSelecionada = nota;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎸 Braço do Contrabaixo'),
      ),
      body: SingleChildScrollView(
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

              const SizedBox(height: 6),

              const Text(
                'Afinação padrão • E • A • D • G',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 18),

              _construirNotaSelecionada(),

              const SizedBox(height: 20),

              _construirBraco(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirNotaSelecionada() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.indigoAccent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.45),
                    blurRadius: 14,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  notaSelecionada,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'NOTA SELECIONADA',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    notaSelecionada,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    'Corda $cordaSelecionada  •  Casa $casaSelecionada',
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirBraco() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF5A3825),
                Color(0xFF3A2418),
                Color(0xFF5A3825),
              ],
            ),
          ),
          child: Column(
            children: [
              _construirCabecalho(),

              const SizedBox(height: 4),

              ...cordas.map(
                (corda) => _construirCorda(corda),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirCabecalho() {
    return Row(
      children: [
        Container(
          width: 45,
          height: 34,
          alignment: Alignment.center,
          child: const Text(
            '↓',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
            ),
          ),
        ),

        ...List.generate(
          25,
          (casa) => Container(
            width: 58,
            height: 34,
            alignment: Alignment.center,
            child: Text(
              '$casa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: casa == 12 || casa == 24
                    ? Colors.blueAccent
                    : Colors.white70,
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
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),

        ...List.generate(
          25,
          (casa) {
            final nota = notaNaCasa(
              corda,
              casa,
            );

            return _construirCasa(
              corda,
              casa,
              nota,
            );
          },
        ),
      ],
    );
  }

  Widget _construirCasa(
    String corda,
    int casa,
    String nota,
  ) {
    final selecionada =
        corda == cordaSelecionada &&
        casa == casaSelecionada;

    final ehTonica = nota == 'C';

    return GestureDetector(
      onTap: () {
        selecionarNota(
          corda,
          casa,
          nota,
        );
      },
      child: Container(
        width: 58,
        height: 64,
        decoration: BoxDecoration(
          gradient: selecionada
              ? const LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.indigoAccent,
                  ],
                )
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF68432B),
                    Color(0xFF422719),
                  ],
                ),
          border: Border(
            right: BorderSide(
              color: Colors.white70,
              width: casa == 0 ? 4 : 2,
            ),
            bottom: const BorderSide(
              color: Colors.black54,
              width: 1,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (ehMarcador(casa) && casa != 0)
              _construirMarcador(casa),

            Center(
              child: Container(
                width: selecionada ? 42 : 34,
                height: selecionada ? 42 : 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selecionada
                      ? Colors.blueAccent
                      : ehTonica
                          ? Colors.blueAccent
                              .withOpacity(0.20)
                          : Colors.transparent,
                  border: ehTonica && !selecionada
                      ? Border.all(
                          color: Colors.blueAccent,
                          width: 2,
                        )
                      : null,
                  boxShadow: selecionada
                      ? [
                          BoxShadow(
                            color: Colors.blueAccent
                                .withOpacity(0.55),
                            blurRadius: 10,
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    nota,
                    style: TextStyle(
                      fontSize: selecionada ? 16 : 14,
                      fontWeight: FontWeight.bold,
                      color: selecionada
                          ? Colors.white
                          : Colors.white70,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: 1,
              child: Container(
                height: 2,
                color: Colors.white10,
              ),
            ),

            Positioned(
              top: 0,
              bottom: 0,
              right: 2,
              child: Container(
                width: _espessuraCorda(corda),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirMarcador(int casa) {
    if (ehMarcadorDuplo(casa)) {
      return Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
        children: [
          _bolinhaMarcador(),
          _bolinhaMarcador(),
        ],
      );
    }

    return _bolinhaMarcador();
  }

  Widget _bolinhaMarcador() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white54,
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 3,
          ),
        ],
      ),
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