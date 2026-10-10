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
    if (alpha <= 0) return;

    final preenchimento = Paint()
      ..color = const Color(0xFF172B3B).withOpacity(alpha * 0.82)
      ..style = PaintingStyle.fill;

    final contorno = Paint()
      ..color = Colors.cyanAccent.withOpacity(alpha * 0.9)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final articulacao = Paint()
      ..color = Colors.white.withOpacity(alpha * 0.7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final estiloTexto = TextStyle(
      color: Colors.white.withOpacity(alpha),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    final validas = posicoes.where((p) {
      return ordemCordas.contains(p.corda) &&
          p.casa >= 0 &&
          p.casa <= 12;
    }).toList();

    if (validas.isEmpty) return;

    final centros = <Offset>[];

    for (final p in validas) {
      final linha = ordemCordas.indexOf(p.corda);
      centros.add(
        Offset(
          larguraEtiqueta + larguraCasa * p.casa + larguraCasa / 2,
          alturaCabecalho + alturaCorda * linha + alturaCorda / 2,
        ),
      );
    }

    // Calcula a área que contém as posições dos dedos.
    double minX = centros.first.dx;
    double maxX = centros.first.dx;
    double minY = centros.first.dy;
    double maxY = centros.first.dy;

    for (final centro in centros) {
      if (centro.dx < minX) minX = centro.dx;
      if (centro.dx > maxX) maxX = centro.dx;
      if (centro.dy < minY) minY = centro.dy;
      if (centro.dy > maxY) maxY = centro.dy;
    }

    // Evita que uma única posição produza uma mão minúscula.
    final esquerda = (minX - larguraCasa * 0.42).clamp(
      larguraEtiqueta + 2,
      size.width - 10,
    ).toDouble();

    final direita = (maxX + larguraCasa * 0.42).clamp(
      larguraEtiqueta + 12,
      size.width - 4,
    ).toDouble();

    final topo = (minY - alturaCorda * 0.38).clamp(
      alturaCabecalho + 2,
      size.height - 10,
    ).toDouble();

    final base = (maxY + alturaCorda * 0.38).clamp(
      alturaCabecalho + 12,
      size.height - 4,
    ).toDouble();

    if (direita <= esquerda || base <= topo) return;

    // Palma: forma arredondada, atrás das marcações dos dedos.
    final palma = RRect.fromRectAndRadius(
      Rect.fromLTRB(esquerda, topo, direita, base),
      const Radius.circular(24),
    );

    canvas.drawRRect(palma, preenchimento);
    canvas.drawRRect(palma, contorno);

    // Desenha pequenas ligações curvas entre posições próximas,
    // sem atravessar o braço com linhas longas.
    for (int i = 0; i < centros.length; i++) {
      for (int j = i + 1; j < centros.length; j++) {
        final a = centros[i];
        final b = centros[j];

        final distancia = (a - b).distance;
        if (distancia > larguraCasa * 1.7) continue;

        final caminho = Path()
          ..moveTo(a.dx, a.dy)
          ..quadraticBezierTo(
            (a.dx + b.dx) / 2,
            (a.dy + b.dy) / 2 - 5,
            b.dx,
            b.dy,
          );

        canvas.drawPath(caminho, articulacao);
      }
    }

    // Cada posição recebe uma marca arredondada com o número do dedo.
    for (int i = 0; i < validas.length; i++) {
      final p = validas[i];
      final centro = centros[i];

      final dedo = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: centro,
          width: 31,
          height: 31,
        ),
        const Radius.circular(12),
      );

      canvas.drawRRect(dedo, preenchimento);
      canvas.drawRRect(dedo, contorno);

      final texto = TextPainter(
        text: TextSpan(
          text: '${p.dedo}',
          style: estiloTexto,
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      texto.paint(
        canvas,
        Offset(
          centro.dx - texto.width / 2,
          centro.dy - texto.height / 2,
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
