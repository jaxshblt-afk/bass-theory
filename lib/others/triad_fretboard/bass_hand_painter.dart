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
    if (posicoes.isEmpty) return;

    final alpha = opacidade.clamp(0.0, 1.0).toDouble();

    final tintaLinha = Paint()
      ..color = Colors.cyanAccent.withOpacity(alpha * 0.75)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final tintaDedo = Paint()
      ..color = const Color(0xFF101820).withOpacity(alpha * 0.90)
      ..style = PaintingStyle.fill;

    final tintaBorda = Paint()
      ..color = Colors.cyanAccent.withOpacity(alpha)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final tintaTexto = TextStyle(
      color: Colors.white.withOpacity(alpha),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    final pontos = <Offset>[];

    for (final posicao in posicoes) {
      final indiceCorda = ordemCordas.indexOf(posicao.corda);

      if (indiceCorda < 0 ||
          posicao.casa < 0 ||
          posicao.casa > 12) {
        continue;
      }

      final x = larguraEtiqueta +
          larguraCasa * posicao.casa +
          larguraCasa / 2;

      final y = alturaCabecalho +
          alturaCorda * indiceCorda +
          alturaCorda / 2;

      pontos.add(Offset(x, y));
    }

    if (pontos.isEmpty) return;

    if (pontos.length > 1) {
      final caminho = Path()
        ..moveTo(pontos.first.dx, pontos.first.dy);

      for (int i = 1; i < pontos.length; i++) {
        caminho.lineTo(pontos[i].dx, pontos[i].dy);
      }

      canvas.drawPath(caminho, tintaLinha);
    }

    for (final posicao in posicoes) {
      final indiceCorda = ordemCordas.indexOf(posicao.corda);

      if (indiceCorda < 0 ||
          posicao.casa < 0 ||
          posicao.casa > 12) {
        continue;
      }

      final centro = Offset(
        larguraEtiqueta +
            larguraCasa * posicao.casa +
            larguraCasa / 2,
        alturaCabecalho +
            alturaCorda * indiceCorda +
            alturaCorda / 2,
      );

      const raio = 15.0;

      canvas.drawCircle(centro, raio, tintaDedo);
      canvas.drawCircle(centro, raio, tintaBorda);

      final painter = TextPainter(
        text: TextSpan(
          text: '${posicao.dedo}',
          style: tintaTexto,
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      painter.paint(
        canvas,
        Offset(
          centro.dx - painter.width / 2,
          centro.dy - painter.height / 2,
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
