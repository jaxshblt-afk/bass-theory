import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class KeyDetectorPage extends StatefulWidget {
  const KeyDetectorPage({super.key});

  @override
  State<KeyDetectorPage> createState() => _KeyDetectorPageState();
}

class _KeyDetectorPageState extends State<KeyDetectorPage> {
  final AudioRecorder _recorder = AudioRecorder();

  StreamSubscription<List<int>>? _audioSubscription;

  bool _microfoneAtivo = false;

  double _frequencia = 0;
  String _nota = '—';
  String _status = 'Nenhum som detectado';

  final List<double> _leituras = [];

  String? _notaEstavel;
  int _contadorNota = 0;

  @override
  void dispose() {
    _audioSubscription?.cancel();
    _recorder.stop();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _ativarMicrofone() async {
    final permitido = await _recorder.hasPermission();

    if (!permitido) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permita o acesso ao microfone.'),
        ),
      );

      return;
    }

    try {
      final stream = await _recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 44100,
          numChannels: 1,
        ),
      );

      await _audioSubscription?.cancel();

      _audioSubscription = stream.listen(_analisarAudio);

      if (!mounted) return;

      setState(() {
        _microfoneAtivo = true;
        _status = 'Ouvindo... cante uma nota';
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao iniciar microfone: $e'),
        ),
      );
    }
  }

  void _analisarAudio(List<int> dados) {
    if (dados.length < 2000) return;

    final samples = <double>[];

    for (int i = 0; i + 1 < dados.length; i += 2) {
      int valor = dados[i] | (dados[i + 1] << 8);

      if (valor > 32767) {
        valor -= 65536;
      }

      samples.add(valor.toDouble());
    }

    if (samples.length < 1000) return;

    double energia = 0;

    for (final sample in samples) {
      energia += sample * sample;
    }

    energia = sqrt(energia / samples.length);

    if (energia < 100) {
      return;
    }

    final frequencia = _detectarFrequencia(
      samples,
      44100,
    );

    if (frequencia <= 0) return;

    // Faixa aproximada da voz.
    if (frequencia < 60 || frequencia > 1000) {
      return;
    }

    _leituras.add(frequencia);

    if (_leituras.length > 8) {
      _leituras.removeAt(0);
    }

    double media = 0;

    for (final valor in _leituras) {
      media += valor;
    }

    media /= _leituras.length;

    final nota = _encontrarNota(media);

    if (_notaEstavel == nota) {
      _contadorNota++;
    } else {
      _notaEstavel = nota;
      _contadorNota = 1;
    }

    if (_contadorNota < 3) {
      return;
    }

    if (!mounted) return;

    setState(() {
      _frequencia = media;
      _nota = nota;
      _status = 'Nota detectada';
    });
  }

  double _detectarFrequencia(
    List<double> samples,
    int sampleRate,
  ) {
    const minFreq = 60.0;
    const maxFreq = 1000.0;

    final minLag = (sampleRate / maxFreq).round();
    final maxLag = (sampleRate / minFreq).round();

    double melhorCorrelacao = 0;
    int melhorLag = 0;

    for (int lag = minLag; lag <= maxLag; lag++) {
      double soma = 0;

      final limite = samples.length - lag;

      for (int i = 0; i < limite; i++) {
        soma += samples[i] * samples[i + lag];
      }

      if (soma > melhorCorrelacao) {
        melhorCorrelacao = soma;
        melhorLag = lag;
      }
    }

    if (melhorLag == 0) return 0;

    return sampleRate / melhorLag;
  }

  String _encontrarNota(double frequencia) {
    const notas = [
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

    final midi =
        69 + 12 * (log(frequencia / 440) / ln2);

    final indice = midi.round() % 12;

    return notas[indice];
  }

  Future<void> _desativarMicrofone() async {
    await _audioSubscription?.cancel();

    _audioSubscription = null;

    await _recorder.stop();

    if (!mounted) return;

    setState(() {
      _microfoneAtivo = false;
      _frequencia = 0;
      _nota = '—';
      _status = 'Nenhum som detectado';
    });

    _leituras.clear();
    _notaEstavel = null;
    _contadorNota = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Descobrir o Tom'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          Icon(
            _microfoneAtivo
                ? Icons.mic
                : Icons.mic_none,
            size: 90,
            color: _microfoneAtivo
                ? Colors.redAccent
                : Colors.blueAccent,
          ),

          const SizedBox(height: 20),

          const Text(
            'DESCUBRIR O TOM',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            _microfoneAtivo
                ? '🎤 Ouvindo... cante uma nota'
                : 'Cante uma música a capella',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: _microfoneAtivo
                ? _desativarMicrofone
                : _ativarMicrofone,
            icon: Icon(
              _microfoneAtivo
                  ? Icons.stop
                  : Icons.mic,
            ),
            label: Text(
              _microfoneAtivo
                  ? 'PARAR DE OUVIR'
                  : 'COMEÇAR A OUVIR',
            ),
          ),

          const SizedBox(height: 30),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Resultado da análise',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    _nota,
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    _frequencia > 0
                        ? '${_frequencia.toStringAsFixed(1)} Hz'
                        : '0 Hz',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    _status,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Tom provável: —',
                    style: TextStyle(fontSize: 18),
                  ),

                  const Text(
                    'Maior / menor: —',
                    style: TextStyle(fontSize: 18),
                  ),

                  const Text(
                    'Confiança: —',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            '💡 Cante notas longas e claras para melhorar a análise.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}