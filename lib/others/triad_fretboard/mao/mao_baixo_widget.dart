import 'package:flutter/material.dart';

class MaoBaixoWidget extends StatelessWidget {
  final double largura;
  final double altura;
  final double opacidade;
  final String? imagemAsset;

  const MaoBaixoWidget({
    super.key,
    required this.largura,
    required this.altura,
    this.opacidade = 1.0,
    this.imagemAsset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: largura,
      height: altura,
      child: Opacity(
        opacity: opacidade.clamp(0.0, 1.0).toDouble(),
        child: imagemAsset != null
            ? Image.asset(
                imagemAsset!,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              )
            : const Center(
                child: Text(
                  'Aguardando imagem da mão',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ),
      ),
    );
  }
}
