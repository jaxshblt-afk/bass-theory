class PosicaoDedo {
  final String corda;
  final int casa;
  final String nota;
  final int dedo;

  const PosicaoDedo({
    required this.corda,
    required this.casa,
    required this.nota,
    required this.dedo,
  });
}

String normalizarNotaModelo(String nota) {
  return nota
      .trim()
      .replaceAll('♯', '#')
      .replaceAll('♭', 'b')
      .toUpperCase();
}

List<PosicaoDedo> calcularPosicoesDedos({
  required List<String> notasTriade,
  required List<String> cordas,
  required Map<String, int> afinacao,
  required List<String> notasCromaticas,
  int casasMaximas = 12,
}) {
  if (notasTriade.isEmpty || notasCromaticas.isEmpty) {
    return [];
  }

  final notasTriadeNormalizadas =
      notasTriade.map(normalizarNotaModelo).toSet();

  final posicoes = <PosicaoDedo>[];

  for (final corda in cordas) {
    final notaBase = afinacao[corda];

    if (notaBase == null) continue;

    for (int casa = 0; casa <= casasMaximas; casa++) {
      final indice = (notaBase + casa) % notasCromaticas.length;
      final nota = notasCromaticas[indice];

      if (notasTriadeNormalizadas.contains(
        normalizarNotaModelo(nota),
      )) {
        final indiceNota =
            notasTriade.indexWhere(
          (n) =>
              normalizarNotaModelo(n) ==
              normalizarNotaModelo(nota),
        );

        // 1 = indicador da tônica
        // 2 e 3 = demais notas da tríade
        final dedo = indiceNota < 0 ? 1 : indiceNota + 1;

        posicoes.add(
          PosicaoDedo(
            corda: corda,
            casa: casa,
            nota: nota,
            dedo: dedo,
          ),
        );
      }
    }
  }

  return posicoes;
}
