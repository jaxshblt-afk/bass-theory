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
        title: const Text(
          '🎸 Braço do Contrabaixo',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent
                        .withOpacity(0.4),
                    blurRadius: 12,
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

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nota selecionada',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$notaSelecionada • '
                  'Corda $cordaSelecionada • '
                  'Casa $casaSelecionada',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirBraco() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          _construirCabecalho(),

          const SizedBox(height: 4),

          ...cordas.map(
            (corda) => _construirCorda(corda),
          ),
        ],
      ),
    );
  }

  Widget _construirCabecalho() {
    return Row(
      children: [
        Container(
          width: 45,
          height: 30,
          alignment: Alignment.center,
          child: const Text(''),
        ),

        ...List.generate(
          25,
          (casa) => Container(
            width: 58,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              '$casa',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
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
          height: 62,
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
        height: 62,
        decoration: BoxDecoration(
          color: selecionada
              ? Colors.blueAccent.withOpacity(0.45)
              : const Color(0xFF3A2A20),

          border: Border(
            right: BorderSide(
              color: Colors.white54,
              width: casa == 0 ? 3 : 1,
            ),
            bottom: const BorderSide(
              color: Colors.white12,
            ),
          ),
        ),

        child: Stack(
          alignment: Alignment.center,
          children: [
            if (ehMarcador(casa) &&
                casa != 0)
              _construirMarcador(casa),

            Center(
              child: Container(
                width: selecionada ? 40 : 32,
                height: selecionada ? 40 : 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: selecionada
                      ? Colors.blueAccent
                      : Colors.transparent,

                  border: ehTonica &&
                          !selecionada
                      ? Border.all(
                          color: Colors.blueAccent,
                          width: 2,
                        )
                      : null,
                ),

                child: Center(
                  child: Text(
                    nota,
                    style: TextStyle(
                      fontSize:
                          selecionada ? 16 : 14,
                      fontWeight:
                          FontWeight.bold,
                      color: selecionada
                          ? Colors.white
                          : Colors.white70,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              bottom: 0,
              right: 2,
              child: Container(
                width:
                    _espessuraCorda(corda),
                color: Colors.white70,
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
      width: 9,
      height: 9,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white38,
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
