import 'dart:math';

class EarTrainingQuestion {
  final String nota;
  final List<String> opcoes;

  const EarTrainingQuestion({
    required this.nota,
    required this.opcoes,
  });
}

class EarTrainingService {
  final Random _random = Random();

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

  EarTrainingQuestion gerarPergunta() {
    final nota =
        notas[_random.nextInt(notas.length)];

    final opcoes = <String>[nota];

    while (opcoes.length < 4) {
      final outra =
          notas[_random.nextInt(notas.length)];

      if (!opcoes.contains(outra)) {
        opcoes.add(outra);
      }
    }

    opcoes.shuffle(_random);

    return EarTrainingQuestion(
      nota: nota,
      opcoes: opcoes,
    );
  }

  bool verificarResposta(
    EarTrainingQuestion pergunta,
    String resposta,
  ) {
    return resposta == pergunta.nota;
  }

  void resetar() {
    // Reservado para futuras estatísticas.
  }
}