import 'package:flutter/material.dart';

class IntervalFretboardPage extends StatefulWidget {
  final String titulo;
  final dynamic semitons;
  final String formula;

  const IntervalFretboardPage({
    super.key,
    required this.titulo,
    required this.semitons,
    required this.formula,
  });

  @override
  State<IntervalFretboardPage> createState() =>
      _IntervalFretboardPageState();
}

class _IntervalFretboardPageState
    extends State<IntervalFretboardPage> {
  static const notas = [
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

  String _notaSelecionada = 'C';

  final cordas = const {
    'E': 4,
    'A': 9,
    'D': 2,
    'G': 7,
  };

  List<int> get _semitonsLista {
    if (widget.semitons is int) {
      return [0, widget.semitons as int];
    }

    return List<int>.from(widget.semitons as List);
  }

  String _notaNaCasa(String corda, int casa) {
    final inicio = cordas[corda]!;
    return notas[(inicio + casa) % 12];
  }

  bool _ehNotaDoIntervalo(String nota) {
    final fundamental = notas.indexOf(_notaSelecionada);
    final indice = notas.indexOf(nota);

    final distancia =
        (indice - fundamental + 12) % 12;

    return _semitonsLista.contains(distancia);
  }

  bool _ehFundamental(String nota) {
    return nota == _notaSelecionada;
  }

  void _selecionarNota(String nota) {
    setState(() {
      _notaSelecionada = nota;
    });
  }

  Color _corDaNota(String nota) {
    if (_ehFundamental(nota)) {
      return Colors.blueAccent;
    }

    if (_ehNotaDoIntervalo(nota)) {
      return Colors.orangeAccent;
    }

    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    const cordasNomes = ['E', 'A', 'D', 'G'];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            widget.titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Fórmula: ${widget.formula}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Escolha a nota fundamental:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: notas.map((nota) {
              final selecionada =
                  nota == _notaSelecionada;

              return ChoiceChip(
                label: Text(nota),
                selected: selecionada,
                onSelected: (_) {
                  _selecionarNota(nota);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 25),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Text(
                    'BRAÇO DO CONTRABAIXO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 40),

                            ...List.generate(
                              13,
                              (casa) => SizedBox(
                                width: 64,
                                child: Text(
                                  '$casa',
                                  textAlign:
                                      TextAlign.center,
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        ...cordasNomes.map(
                          (corda) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    corda,
                                    style:
                                        const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          Colors.blueAccent,
                                    ),
                                  ),
                                ),

                                ...List.generate(
                                  13,
                                  (casa) {
                                    final nota =
                                        _notaNaCasa(
                                      corda,
                                      casa,
                                    );

                                    final cor =
                                        _corDaNota(
                                      nota,
                                    );

                                    return Container(
                                      width: 64,
                                      height: 58,
                                      margin:
                                          const EdgeInsets
                                              .all(1),
                                      decoration:
                                          BoxDecoration(
                                        color: cor,
                                        border:
                                            Border.all(
                                          color: Colors
                                              .white24,
                                        ),
                                        borderRadius:
                                            BorderRadius
                                                .circular(
                                          5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          nota,
                                          style:
                                              TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                            color:
                                                cor ==
                                                        Colors
                                                            .transparent
                                                    ? Colors
                                                        .white
                                                    : Colors
                                                        .black,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 8),

              const Text('Tônica'),

              const SizedBox(width: 25),

              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 8),

              const Text('Intervalo / Arpejo'),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            '🔵 $_notaSelecionada = Tônica',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            '🟠 As notas laranjas mostram as posições do intervalo ou arpejo.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}