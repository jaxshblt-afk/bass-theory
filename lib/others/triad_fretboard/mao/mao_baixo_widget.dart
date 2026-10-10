import 'package:flutter/material.dart';

/// Área visual reservada para a mão do contrabaixista.
/// A mão será posicionada por cima das cordas.
class MaoBaixoWidget extends StatelessWidget {
  final double largura;
  final double altura;
  final double opacidade;

  const MaoBaixoWidget({
    super.key,
    required this.largura,
    required this.altura,
    this.opacidade = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: largura,
      height: altura,
      child: Opacity(
        opacity: opacidade.clamp(0.0, 1.0).toDouble(),
        child: const Center(
          child: Text(
            'MÃO DO CONTRABAIXISTA',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
