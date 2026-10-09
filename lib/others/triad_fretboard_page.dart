
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

class _TriadFretboardPageState
    extends State<TriadFretboardPage> {
  static const List<String> notas = [
    'C', 'C#', 'D', 'D#', 'E', 'F',
    'F#', 'G', 'G#', 'A', 'A#', 'B',
  ];

  // Ordem visual do braço.
  static const List<String> cordas = ['G', 'D', 'A', 'E'];

  // Afinação padrão: E - A - D - G.
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

  bool fazParteDaTriade(String nota) =>
      widget.notasTriade.contains(nota);

  bool ehTonica(String nota) =>
      widget.notasTriade.isNotEmpty &&
      nota == widget.notasTriade.first;

  // Guia visual: 1, 2 e 3 representam as três notas
  // da tríade. É uma sugestão didática, não uma
  // digitação universal para todas as posições.
  int numeroDedo(String nota) {
    final indice = widget.notasTriade.indexOf(nota);
    if (indice < 0) return 0;
    return indice + 1;
  }

  void selecionarCasa(String corda, int casa, String nota) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                'Notas: ${widget.notasTriade.join(' • ')}',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 15),

              _construirNotaSelecionada(),
              const SizedBox(height: 12),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Mão-guia transparente',
                        ),
                        subtitle: const Text(
                          'Mostrar números dos dedos nas notas',
                        ),
                        value: mostrarMao,
                        onChanged: (valor) {
                          setState(() {
                            mostrarMao = valor;
                          });
                        },
                      ),
                      if (mostrarMao)
                        Row(
                          children: [
                            const Text('Transparência'),
                            Expanded(
                              child: Slider(
                                value: opacidadeMao,
                                min: 0.10,
                                max: 0.65,
                                divisions: 11,
                                label:
                                    '${(opacidadeMao * 100).round()}%',
                                onChanged: (valor) {
                                  setState(() {
                                    opacidadeMao = valor;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 8,
                    children: [
                      _legenda(Colors.blueAccent, 'Tônica'),
                      _legenda(Colors.orangeAccent, 'Tríade'),
                      _legenda(Colors.white, 'Selecionada'),
                      if (mostrarMao)
                        _legenda(
                          Colors.white.withOpacity(opacidadeMao),
                          'Dedo 1, 2 ou 3',
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              _construirBraco(),
              const SizedBox(height: 20),

              const Text(
                'Toque em uma casa para selecionar uma nota. '
                'Os números são um guia inicial para estudar '
                'as três notas da tríade. A digitação ideal '
                'pode mudar conforme a posição no braço.',
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
                decoration: const BoxDecoration(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nota selecionada',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$notaSelecionada • Corda $cordaSelecionada • '
                    'Casa $casaSelecionada',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tonica ? 'Tônica da tríade' : 'Nota da tríade',
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white38),
          ),
        ),
        const SizedBox(width: 6),
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
            ...cordas.map(_construirCorda),
          ],
        ),
      ),
    );
  }

  Widget _cabecalho() {
    return Row(
      children: [
        Container(width: 45, height: 32),
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
        ...List.generate(25, (casa) {
          final nota = notaNaCasa(corda, casa);
          return _construirCasa(
            corda,
            casa,
            nota,
            fazParteDaTriade(nota),
            ehTonica(nota),
            corda == cordaSelecionada &&
                casa == casaSelecionada,
          );
        }),
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

    final dedo = numeroDedo(nota);

    return GestureDetector(
      onTap: () => selecionarCasa(corda, casa, nota),
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
                width: selecionada ? 44 : tonica ? 42 : 38,
                height: selecionada ? 44 : tonica ? 42 : 38,
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
                      color: cor.withOpacity(0.35),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    nota,
                    style: TextStyle(
                      color: selecionada ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

            // Marcador semitransparente do dedo.
            if (mostrarMao && pertence && dedo > 0)
              Positioned(
                top: 2,
                left: 2,
                child: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(opacidadeMao),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.75),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '$dedo',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
