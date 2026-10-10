Escrita
import 'package:flutter/material.dart';

import 'triad_fretboard_models.dart';

class MaoBaixoPainter extends CustomPainter {
  final List<PosicaoDedo> posicoes;
  final double opacidade;
  final double larguraEtiqueta;
  final double larguraCasa;
  final double alturaCabecalho;
  final double alturaCorda;

  const MaoBaixoPainter({
    required this.posicoes,
    required this.opacidade,
    required this.larguraEtiqueta,
    required this.larguraCasa,
    required this.alturaCabecalho,
    required this.alturaCorda,
  });

  static const List<String> ordemCordas = ['G', 'D', 'A', 'E'];

  @override
  void paint(Canvas canvas, Size size) {
    final alpha = opacidade.clamp(0.0, 1.0).toDouble();
    if (alpha <= 0) return;

    final fundoDedo = Paint()
      ..color = const Color(0xFF102638).withOpacity(alpha * 0.9)
      ..style = PaintingStyle.fill;

    final bordaDedo = Paint()
      ..color = Colors.cyanAccent.withOpacity(alpha)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final linhaArticulacao = Paint()
      ..color = Colors.cyanAccent.withOpacity(alpha * 0.45)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final estiloNumero = TextStyle(
      color: Colors.white.withOpacity(alpha),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    final validas = posicoes.where((p) =>
        ordemCordas.contains(p.corda) &&
        p.casa >= 0 &&
        p.casa <= 12).toList();

    // Desenha apenas pequenas articulações entre dedos próximos.
    for (int i = 0; i < validas.length; i++) {
      final a = validas[i];
      final linhaA = ordemCordas.indexOf(a.corda);
      final pontoA = Offset(
        larguraEtiqueta + larguraCasa * a.casa + larguraCasa / 2,
        alturaCabecalho + alturaCorda * linhaA + alturaCorda / 2,
      );

      for (int j = i + 1; j < validas.length; j++) {
        final b = validas[j];

        // Não conecta o mesmo dedo a todas as notas.
        if (a.dedo != b.dedo) continue;

        final linhaB = ordemCordas.indexOf(b.corda);
        final pontoB = Offset(
          larguraEtiqueta + larguraCasa * b.casa + larguraCasa / 2,
          alturaCabecalho + alturaCorda * linhaB + alturaCorda / 2,
        );

        if ((pontoA - pontoB).distance > larguraCasa * 1.25) {
          continue;
        }

        canvas.drawLine(pontoA, pontoB, linhaArticulacao);
      }
    }

    // Cada dedo é mostrado individualmente.
    for (final p in validas) {
      final linha = ordemCordas.indexOf(p.corda);

      final centro = Offset(
        larguraEtiqueta + larguraCasa * p.casa + larguraCasa / 2,
        alturaCabecalho + alturaCorda * linha + alturaCorda / 2,
      );

      final areaDedo = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: centro,
          width: 30,
          height: 30,
        ),
        const Radius.circular(15),
      );

      canvas.drawRRect(areaDedo, fundoDedo);
      canvas.drawRRect(areaDedo, bordaDedo);

      final numero = TextPainter(
        text: TextSpan(
          text: '${p.dedo}',
          style: estiloNumero,
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      numero.paint(
        canvas,
        Offset(
          centro.dx - numero.width / 2,
          centro.dy - numero.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant MaoBaixoPainter oldDelegate) {
    return oldDelegate.posicoes != posicoes ||
        oldDelegate.opacidade != opacidade ||
        oldDelegate.larguraEtiqueta != larguraEtiqueta ||
        oldDelegate.larguraCasa != larguraCasa ||
        oldDelegate.alturaCabecalho != alturaCabecalho ||
        oldDelegate.alturaCorda != alturaCorda;
  }
}