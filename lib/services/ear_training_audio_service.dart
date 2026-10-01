import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

class EarTrainingAudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> tocarNota({
    required String nota,
    int oitava = 3,
    int duracaoMs = 1200,
  }) async {
    final frequencia = _frequenciaDaNota(nota, oitava);

    final wav = _gerarWav(
      frequencia: frequencia,
      duracaoMs: duracaoMs,
    );

    await _player.stop();

    await _player.play(
      BytesSource(wav),
    );
  }

  double _frequenciaDaNota(
    String nota,
    int oitava,
  ) {
    const notas = {
      'C': 0,
      'C#': 1,
      'D': 2,
      'D#': 3,
      'E': 4,
      'F': 5,
      'F#': 6,
      'G': 7,
      'G#': 8,
      'A': 9,
      'A#': 10,
      'B': 11,
    };

    final numeroNota = notas[nota] ?? 0;

    final midi = (oitava + 1) * 12 + numeroNota;

    return (
      440.0 *
      pow(
        2.0,
        (midi - 69) / 12.0,
      )
    ).toDouble();
  }

  Uint8List _gerarWav({
    required double frequencia,
    required int duracaoMs,
  }) {
    const sampleRate = 44100;
    const canais = 1;
    const bitsPorSample = 16;

    final quantidadeSamples =
        (sampleRate * duracaoMs / 1000).round();

    final dados = BytesBuilder();

    for (int i = 0; i < quantidadeSamples; i++) {
      final tempo = i / sampleRate;

      final envelope = _envelope(
        i,
        quantidadeSamples,
      );

      final valor =
          sin(
            2 * pi * frequencia * tempo,
          ) *
          0.45 *
          envelope;

      final sample = (valor * 32767).round();

      dados.add(
        Uint8List(2)
          ..buffer
              .asByteData()
              .setInt16(
                0,
                sample,
                Endian.little,
              ),
      );
    }

    final audioData = dados.toBytes();

    final header = BytesBuilder();

    header.add(
      Uint8List.fromList(
        'RIFF'.codeUnits,
      ),
    );

    _addUint32(
      header,
      36 + audioData.length,
    );

    header.add(
      Uint8List.fromList(
        'WAVE'.codeUnits,
      ),
    );

    header.add(
      Uint8List.fromList(
        'fmt '.codeUnits,
      ),
    );

    _addUint32(header, 16);
    _addUint16(header, 1);
    _addUint16(header, canais);
    _addUint32(header, sampleRate);

    final byteRate =
        sampleRate *
        canais *
        bitsPorSample ~/
        8;

    _addUint32(header, byteRate);

    final blockAlign =
        canais *
        bitsPorSample ~/
        8;

    _addUint16(header, blockAlign);
    _addUint16(header, bitsPorSample);

    header.add(
      Uint8List.fromList(
        'data'.codeUnits,
      ),
    );

    _addUint32(
      header,
      audioData.length,
    );

    header.add(audioData);

    return header.toBytes();
  }

  double _envelope(
    int indice,
    int total,
  ) {
    const ataque = 0.05;
    const finalizacao = 0.15;

    final progresso = indice / total;

    if (progresso < ataque) {
      return progresso / ataque;
    }

    if (progresso > 1 - finalizacao) {
      return (1 - progresso) / finalizacao;
    }

    return 1;
  }

  void _addUint16(
    BytesBuilder builder,
    int valor,
  ) {
    final bytes = Uint8List(2);

    bytes.buffer
        .asByteData()
        .setUint16(
          0,
          valor,
          Endian.little,
        );

    builder.add(bytes);
  }

  void _addUint32(
    BytesBuilder builder,
    int valor,
  ) {
    final bytes = Uint8List(4);

    bytes.buffer
        .asByteData()
        .setUint32(
          0,
          valor,
          Endian.little,
        );

    builder.add(bytes);
  }

  Future<void> parar() async {
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
