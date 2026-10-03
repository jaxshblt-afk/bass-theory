import 'package:flutter/material.dart';

class TetradFretboardPage extends StatefulWidget {
  final String nome;
  final String cifra;
  final List<String> notasTetrade;

  const TetradFretboardPage({
    super.key,
    required this.nome,
    required this.cifra,
    required this.notasTetrade,
  });

  @override
  State<TetradFretboardPage> createState() =>
      _TetradFretboardPageState();
}

class _TetradFretboardPageState
    extends State<TetradFretboardPage> {
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

  String? cordaSelecionada;
  int? casaSelecionada;
  String? notaSelecionada;

  String notaNaCasa(String corda, int casa) {
    final inicio = afinacao[corda]!;
    return notas[(inicio + casa) % 12];
  }

  bool fazParteDaTetrade(String nota) {
    return widget.notasTetrade.contains(nota);
  }

  bool ehTonica(String nota) {
    return widget.notasTetrade.isNotEmpty &&
        nota == widget.notasTetrade.first;
  }

  void selecionarCasa(
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
        title: Text('🎸 ${widget.cifra}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                widget.nome,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.cifra,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Notas: ${widget.notasTetrade.join(' • ')}',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 15),

              _construirNotaSelecionada(),

              const SizedBox(height: 15),

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
                      const SizedBox(width: 18),
                      _legenda(
                        Colors.white,
                        'Selecionada',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _construirBraco(),

              const SizedBox(height: 20),

              const Text(
                'As notas destacadas mostram as notas da tétrade no braço. Toque em uma casa para selecioná-la.',
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

  Widget _construirNotaSelecionada() {
    if (notaSelecionada == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white12,
                ),
                child: const Center(
                  child: Text(
                    '?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              const Expanded(
                child: Text(
                  'Toque em uma casa do braço',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final tonica = ehTonica(notaSelecionada!);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
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
                        .withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  notaSelecionada!,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    tonica
                        ? 'Tônica da tétrade'
                        : 'Nota da tétrade',
                    style: TextStyle(
                      color: tonica
                          ? Colors.blueAccent
                          : Colors.orangeAccent,
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

  Widget _legenda(Color cor, String texto) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
            border: cor == Colors.white
                ? Border.all(
                    color: Colors.white54,
                  )
                : null,
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

            final selecionada =
                corda == cordaSelecionada &&
                casa == casaSelecionada;

            return _construirCasa(
              corda,
              casa,
              nota,
              pertence,
              tonica,
              selecionada,
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
    bool pertence,
    bool tonica,
    bool selecionada,
  ) {
    Color? cor;

    if (selecionada) {
      cor = Colors.white;
    } else if (tonica) {
      cor = Colors.blueAccent;
    } else if (pertence) {
      cor = Colors.orangeAccent;
    }

    return GestureDetector(
      onTap: () {
        selecionarCasa(
          corda,
          casa,
          nota,
        );
      },
      child: Container(
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
            if (cor != null)
              Container(
                width: selecionada
                    ? 44
                    : tonica
                        ? 42
                        : 38,
                height: selecionada
                    ? 44
                    : tonica
                        ? 42
                        : 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cor,
                  border: selecionada
                      ? Border.all(
                          color: Colors.blueAccent,
                          width: 3,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: cor.withOpacity(0.45),
                      blurRadius: 9,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    nota,
                    style: TextStyle(
                      color: selecionada
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.bold,
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