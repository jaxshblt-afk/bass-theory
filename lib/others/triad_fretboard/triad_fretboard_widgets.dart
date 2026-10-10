import 'package:flutter/material.dart';

import 'triad_fretboard_models.dart';
import 'bass_hand_painter.dart';

class TriadFretboardWidget extends StatelessWidget {
  final List<String> notasTriade;
  final String? cordaSelecionada;
  final int? casaSelecionada;
  final bool mostrarMao;
  final double opacidadeMao;

  final void Function(
    String corda,
    int casa,
    String nota,
  ) onSelecionarCasa;

  const TriadFretboardWidget({
    super.key,
    required this.notasTriade,
    required this.cordaSelecionada,
    required this.casaSelecionada,
    required this.mostrarMao,
    required this.opacidadeMao,
    required this.onSelecionarCasa,
  });

  static const List<String> notasCromaticas = [
    'C', 'C#', 'D', 'D#', 'E', 'F',
    'F#', 'G', 'G#', 'A', 'A#', 'B',
  ];

  static const List<String> cordas = ['G', 'D', 'A', 'E'];

  static const Map<String, int> afinacao = {
    'E': 4,
    'A': 9,
    'D': 2,
    'G': 7,
  };

  static const double larguraEtiqueta = 45;
  static const double larguraCasa = 58;
  static const double alturaCabecalho = 32;
  static const double alturaCorda = 64;

  String notaNaCasa(String corda, int casa) {
    final notaBase = afinacao[corda] ?? 0;
    return notasCromaticas[
        (notaBase + casa) % notasCromaticas.length];
  }

  String normalizarNota(String nota) {
    return nota
        .trim()
        .replaceAll('♯', '#')
        .replaceAll('♭', 'b')
        .toUpperCase();
  }

  bool fazParteDaTriade(String nota) {
    return notasTriade.any(
      (n) => normalizarNota(n) == normalizarNota(nota),
    );
  }

  bool ehTonica(String nota) {
    if (notasTriade.isEmpty) return false;

    return normalizarNota(nota) ==
        normalizarNota(notasTriade.first);
  }

  @override
  Widget build(BuildContext context) {
    final posicoes = calcularPosicoesDedos(
      notasTriade: notasTriade,
      cordas: cordas,
      afinacao: afinacao,
      notasCromaticas: notasCromaticas,
      casasMaximas: 12,
    );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151922),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.10),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: larguraEtiqueta + larguraCasa * 13,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _construirCabecalho(),
                  ...cordas.map(_construirLinhaCorda),
                ],
              ),
              if (mostrarMao)
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: MaoBaixoPainter(
                        posicoes: posicoes,
                        opacidade: opacidadeMao,
                        larguraEtiqueta: larguraEtiqueta,
                        larguraCasa: larguraCasa,
                        alturaCabecalho: alturaCabecalho,
                        alturaCorda: alturaCorda,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirCabecalho() {
    return SizedBox(
      height: alturaCabecalho,
      child: Row(
        children: [
          Container(
            width: larguraEtiqueta,
            alignment: Alignment.center,
            color: const Color(0xFF242B38),
            child: const Text(
              'Corda',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...List.generate(13, (casa) {
            return Container(
              width: larguraCasa,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF242B38),
                border: Border(
                  right: BorderSide(
                    color: Colors.white.withOpacity(0.10),
                  ),
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.10),
                  ),
                ),
              ),
              child: Text(
                casa == 0 ? 'Solta' : '$casa',
                style: TextStyle(
                  color: casa == 0
                      ? Colors.amberAccent
                      : Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _construirLinhaCorda(String corda) {
    return SizedBox(
      height: alturaCorda,
      child: Row(
        children: [
          Container(
            width: larguraEtiqueta,
            alignment: Alignment.center,
            color: const Color(0xFF242B38),
            child: Text(
              corda,
              style: const TextStyle(
                color: Colors.amberAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...List.generate(13, (casa) {
            final nota = notaNaCasa(corda, casa);

            return _construirCasa(
              corda: corda,
              casa: casa,
              nota: nota,
              pertence: fazParteDaTriade(nota),
              tonica: ehTonica(nota),
              selecionada: cordaSelecionada == corda &&
                  casaSelecionada == casa,
            );
          }),
        ],
      ),
    );
  }

  Widget _construirCasa({
    required String corda,
    required int casa,
    required String nota,
    required bool pertence,
    required bool tonica,
    required bool selecionada,
  }) {
    Color fundo = const Color(0xFF1A202B);
    Color corNota = Colors.white30;

    if (pertence) {
      fundo = tonica
          ? const Color(0xFF123E72)
          : const Color(0xFF633A12);

      corNota = tonica
          ? Colors.lightBlueAccent
          : Colors.orangeAccent;
    }

    if (selecionada) {
      fundo = const Color(0xFF176B50);
      corNota = Colors.white;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onSelecionarCasa(corda, casa, nota),
      child: Container(
        width: larguraCasa,
        height: alturaCorda,
        decoration: BoxDecoration(
          color: fundo,
          border: Border(
            right: BorderSide(
              color: Colors.white.withOpacity(0.12),
            ),
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.12),
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: alturaCorda / 2 - 1,
              child: Container(
                height: 2,
                color: Colors.white.withOpacity(0.25),
              ),
            ),
            if (casa > 0)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: casa == 12 ? 4 : 2,
                  color: Colors.white24,
                ),
              ),
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: pertence
                    ? corNota.withOpacity(0.16)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: selecionada
                    ? Border.all(color: Colors.white, width: 2)
                    : pertence
                        ? Border.all(
                            color: corNota.withOpacity(0.75),
                            width: 1,
                          )
                        : null,
              ),
              child: Text(
                nota,
                style: TextStyle(
                  color: corNota,
                  fontSize: 13,
                  fontWeight: pertence || selecionada
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
