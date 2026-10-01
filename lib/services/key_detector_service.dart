import 'dart:math';

class KeyDetectorResult {
  final String nota;
  final double frequencia;
  final String tom;
  final String tipo;
  final String confianca;

  const KeyDetectorResult({
    required this.nota,
    required this.frequencia,
    required this.tom,
    required this.tipo,
    required this.confianca,
  });
}

class KeyDetectorService {
  final List<String> notas = const [
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

  final Map<String, int> pontuacao = {
    'C': 0,
    'C#': 0,
    'D': 0,
    'D#': 0,
    'E': 0,
    'F': 0,
    'F#': 0,
    'G': 0,
    'G#': 0,
    'A': 0,
    'A#': 0,
    'B': 0,
  };

  String? ultimaNota;
  int contadorNota = 0;

  double detectarFrequencia(
    List<double> samples,
    int sampleRate,
  ) {
    const minFreq = 60.0;
    const maxFreq = 1000.0;

    final minLag =
        (sampleRate / maxFreq).round();

    final maxLag =
        (sampleRate / minFreq).round();

    double melhorCorrelacao = 0;
    int melhorLag = 0;

    for (int lag = minLag;
        lag <= maxLag;
        lag++) {
      double soma = 0;

      final limite =
          samples.length - lag;

      for (int i = 0;
          i < limite;
          i++) {
        soma +=
            samples[i] *
            samples[i + lag];
      }

      if (soma > melhorCorrelacao) {
        melhorCorrelacao = soma;
        melhorLag = lag;
      }
    }

    if (melhorLag == 0) {
      return 0;
    }

    return sampleRate / melhorLag;
  }

  String encontrarNota(double frequencia) {
    if (frequencia <= 0) {
      return '—';
    }

    final midi =
        69 +
        12 *
            (log(frequencia / 440) /
                ln2);

    final indice =
        midi.round() % 12;

    return notas[indice];
  }

  void registrarNota(String nota) {
    if (ultimaNota == nota) {
      contadorNota++;
    } else {
      ultimaNota = nota;
      contadorNota = 1;
    }

    if (contadorNota >= 3) {
      pontuacao[nota] =
          (pontuacao[nota] ?? 0) + 1;
    }
  }

  String calcularTom() {
    int maiorPontuacao = 0;
    String melhorNota = 'C';

    pontuacao.forEach((nota, pontos) {
      if (pontos > maiorPontuacao) {
        maiorPontuacao = pontos;
        melhorNota = nota;
      }
    });

    if (maiorPontuacao == 0) {
      return '—';
    }

    return melhorNota;
  }

  String calcularTipo() {
    final tom = calcularTom();

    if (tom == '—') {
      return '—';
    }

    final indice =
        notas.indexOf(tom);

    const escalaMaior = [
      0,
      2,
      4,
      5,
      7,
      9,
      11,
    ];

    const escalaMenor = [
      0,
      2,
      3,
      5,
      7,
      8,
      10,
    ];

    int maior = 0;
    int menor = 0;

    for (final intervalo
        in escalaMaior) {
      final nota =
          notas[(indice + intervalo) % 12];

      maior +=
          pontuacao[nota] ?? 0;
    }

    for (final intervalo
        in escalaMenor) {
      final nota =
          notas[(indice + intervalo) % 12];

      menor +=
          pontuacao[nota] ?? 0;
    }

    return menor > maior
        ? 'Menor'
        : 'Maior';
  }

  String calcularConfianca() {
    final total = pontuacao.values
        .fold<int>(0, (a, b) => a + b);

    if (total >= 30) {
      return 'Alta';
    }

    if (total >= 12) {
      return 'Média';
    }

    if (total > 0) {
      return 'Baixa';
    }

    return '—';
  }

  void limpar() {
    for (final nota in pontuacao.keys) {
      pontuacao[nota] = 0;
    }

    ultimaNota = null;
    contadorNota = 0;
  }
}