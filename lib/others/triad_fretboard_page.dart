import 'package:flutter/material.dart';

class TriadFretboardPage extends StatefulWidget {
  final String nome;
  final String cifra;
  final List<String> notasTriade;

  const TriadFretboardPage({
    super.key,
    required this.nome,
    required this.cifra,
    required this.notasTriade,
  });

  @override
  State<TriadFretboardPage> createState() =>
      _TriadFretboardPageState();
}

class _TriadFretboardPageState extends State<TriadFretboardPage> {
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

  static const List<String> cordas = ['G', 'D', 'A', 'E'];

  static const Map<String, int> afinacao = {
    'E': 4,
    'A': 9,
    'D': 2,
    'G': 7,
  };

  String? cordaSelecionada;
  int? casaSelecionada;
  String? notaSelecionada;

  bool mostrarMao = true;
  double opacidadeMao = 0.28;

  String notaNaCasa(String corda, int casa) {
    return notas[(afinacao[corda]! + casa) % 12];
  }

  bool fazParteDaTriade(String nota) {
    return widget.notasTriade.contains(nota);
  }

  bool ehTonica(String nota) {
    return widget.notasTriade.isNotEmpty &&
        nota == widget.notasTriade.first;
  }

  void selecionarCasa(String corda, int casa, String nota) {
    setState(() {
      cordaSelecionada = corda;
      casaSelecionada = casa;
      notaSelecionada = nota;
    });
  }

  // Procura uma posição para cada nota da tríade.
  // Prioriza casas próximas e distribui as notas entre as cordas.
  List<PosicaoDedo> _calcularPosicoesDedos() {
    final resultado = <PosicaoDedo>[];
    final notasUsadas = <String>{};
    final casasUsadas = <String>{};

    for (int i = 0; i < widget.notasTriade.length && i < 4; i++) {
      final nota = widget.notasTriade[i];

      if (notasUsadas.contains(nota)) continue;

      PosicaoDedo? melhor;
      double melhorPontuacao = double.infinity;

      for (int cordaIndex = 0;
          cordaIndex < cordas.length;
          cordaIndex++) {
        final corda = cordas[cordaIndex];

        for (int casa = 0; casa <= 12; casa++) {
          if (notaNaCasa(corda, casa) != nota) continue;

          final chave = '$corda-$casa';

          if (casasUsadas.contains(chave)) continue;

          // Favorece uma região compacta do braço.
          final pontuacao =
              casa.toDouble() + cordaIndex * 0.8;

          if (pontuacao < melhorPontuacao) {
            melhorPontuacao = pontuacao;

            melhor = PosicaoDedo(
              nota: nota,
              corda: corda,
              casa: casa,
              dedo: i + 1,
            );
          }
        }
      }

      if (melhor != null) {
        resultado.add(melhor);
        notasUsadas.add(nota);
        casasUsadas.add('${melhor.corda}-${melhor.casa}');
      }
    }

    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tríades no Braço'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        widget.nome,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.cifra,
                        style: const TextStyle(
                          fontSize: 19,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Notas da tríade',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        children: widget.notasTriade.map((nota) {
                          return Chip(
                            label: Text(nota),
                            backgroundColor: ehTonica(nota)
                                ? Colors.blue.shade800
                                : Colors.orange.shade800,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _construirNotaSelecionada(),

              const SizedBox(height: 12),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Mostrar dedos no braço'),
                        subtitle: const Text(
                          'Posiciona os dedos nas notas sugeridas.',
                        ),
                        value: mostrarMao,
                        onChanged: (valor) {
                          setState(() {
                            mostrarMao = valor;
                          });
                        },
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.opacity),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('Transparência dos dedos'),
                          ),
                          Text(
                            '${(opacidadeMao * 100).round()}%',
                          ),
                        ],
                      ),
                      Slider(
                        value: opacidadeMao,
                        min: 0.05,
                        max: 0.65,
                        divisions: 12,
                        label:
                            '${(opacidadeMao * 100).round()}%',
                        onChanged: (valor) {
                          setState(() {
                            opacidadeMao = valor;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _construirLegenda(),

              const SizedBox(height: 12),

              const Text(
                'Braço do contrabaixo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              _construirBraco(),

              const SizedBox(height: 12),

              const Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Os números indicam os dedos sugeridos para '
                    'cada nota: 1 = indicador, 2 = médio, '
                    '3 = anelar e 4 = mínimo. A posição mostrada '
                    'é uma sugestão visual; outras digitações '
                    'podem ser melhores dependendo da música.',
                    textAlign: TextAlign.center,
                  ),
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
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Text(
            'Toque em uma casa do braço para selecionar uma nota.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final pertence = fazParteDaTriade(notaSelecionada!);

    return Card(
      color: pertence
          ? Colors.green.shade900
          : Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
              'Nota: $notaSelecionada',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text('Corda: $cordaSelecionada'),
            Text('Casa: $casaSelecionada'),
            const SizedBox(height: 5),
            Text(
              pertence
                  ? ehTonica(notaSelecionada!)
                      ? 'Tônica da tríade'
                      : 'Nota pertencente à tríade'
                  : 'Nota fora desta tríade',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirLegenda() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 10,
          children: [
            _itemLegenda(Colors.blue, 'Tônica'),
            _itemLegenda(Colors.orange, 'Notas da tríade'),
            _itemLegenda(Colors.grey, 'Outras notas'),
            _itemLegenda(
              Color.fromRGBO(
                255,
                205,
                160,
                opacidadeMao,
              ),
              'Dedos',
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemLegenda(Color cor, String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          texto,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _construirBraco() {
    final posicoes = _calcularPosicoesDedos();

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
            colors: [
              Color(0xFF604027),
              Color(0xFF352016),
              Color(0xFF604027),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _cabecalho(),
            ...cordas.map((corda) {
              return _construirCorda(
                corda,
                posicoes,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _cabecalho() {
    return Row(
      children: [
        const SizedBox(width: 45),
        ...List.generate(25, (index) {
          return Container(
            width: 58,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white24,
                width: 0.5,
              ),
            ),
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 12,
                fontWeight: index == 0
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: index == 0
                    ? Colors.orangeAccent
                    : Colors.white,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _construirCorda(
    String corda,
    List<PosicaoDedo> posicoes,
  ) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 64,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.white38,
              ),
              bottom: BorderSide(
                color: Colors.white24,
              ),
            ),
          ),
          child: Text(
            corda,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ...List.generate(25, (casa) {
          final nota = notaNaCasa(corda, casa);

          final posicaoDedo = posicoes.where(
            (p) => p.corda == corda && p.casa == casa,
          );

          final dedo = posicaoDedo.isEmpty
              ? null
              : posicaoDedo.first;

          return _construirCasa(
            corda: corda,
            casa: casa,
            nota: nota,
            dedo: dedo,
          );
        }),
      ],
    );
  }

  Widget _construirCasa({
    required String corda,
    required int casa,
    required String nota,
    PosicaoDedo? dedo,
  }) {
    final pertence = fazParteDaTriade(nota);
    final tonica = ehTonica(nota);

    final selecionada =
        cordaSelecionada == corda &&
        casaSelecionada == casa;

    Color corNota = Colors.white24;

    if (pertence) {
      corNota = tonica ? Colors.blue : Colors.orange;
    }

    if (selecionada) {
      corNota = Colors.greenAccent;
    }

    return GestureDetector(
      onTap: () {
        selecionarCasa(corda, casa, nota);
      },
      child: Container(
        width: 58,
        height: 64,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.white24,
              width: casa == 0 ? 1.5 : 0.5,
            ),
            bottom: const BorderSide(
              color: Colors.white24,
              width: 0.5,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 30,
              child: Container(
                height: _espessuraCorda(corda),
                color: Colors.white70,
              ),
            ),

            if (casa == 0)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 3,
                  color: Colors.white54,
                ),
              ),

            if (pertence)
              Container(
                width: selecionada ? 39 : 34,
                height: selecionada ? 39 : 34,
                decoration: BoxDecoration(
                  color: corNota,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: selecionada ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: corNota.withOpacity(0.35),
                      blurRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  nota,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else if (selecionada)
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  nota,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // A ponta do dedo fica centralizada na nota escolhida.
            if (mostrarMao && dedo != null)
              Positioned(
                top: 5,
                child: IgnorePointer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                            255,
                            205,
                            160,
                            opacidadeMao,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color.fromRGBO(
                              255,
                              235,
                              215,
                              (opacidadeMao + 0.18).clamp(0.0, 1.0),
                            ),
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${dedo.dedo}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(
                              (opacidadeMao + 0.55).clamp(0.0, 1.0),
                            ),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
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

  double _espessuraCorda(String corda) {
    switch (corda) {
      case 'E':
        return 5;
      case 'A':
        return 4;
      case 'D':
        return 3;
      default:
        return 2;
    }
  }
}

class PosicaoDedo {
  final String nota;
  final String corda;
  final int casa;
  final int dedo;

  const PosicaoDedo({
    required this.nota,
    required this.corda,
    required this.casa,
    required this.dedo,
  });
}