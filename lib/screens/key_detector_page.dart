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

  bool _microfoneAtivo = false;
  String _nota = '—';
  double _frequencia = 0;
  String _confianca = '—';

  StreamSubscription<Amplitude>? _amplitudeSubscription;

  @override
  void dispose() {
    _amplitudeSubscription?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _alternarMicrofone() async {
    if (_microfoneAtivo) {
      await _pararMicrofone();
    } else {
      await _iniciarMicrofone();
    }
  }

  Future<void> _iniciarMicrofone() async {
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

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 44100,
        numChannels: 1,
      ),
      path: '',
    );

    _amplitudeSubscription =
        _recorder.onAmplitudeChanged(
          const Duration(milliseconds: 250),
        ).listen((amplitude) {
          if (!mounted) return;

          final db = amplitude.current;

          setState(() {
            _microfoneAtivo = true;

            if (db > -45) {
              _confianca = 'Boa';
            } else if (db > -60) {
              _confianca = 'Média';
            } else {
              _confianca = 'Baixa';
            }
          });
        });

    setState(() {
      _microfoneAtivo = true;
    });
  }

  Future<void> _pararMicrofone() async {
    await _amplitudeSubscription?.cancel();
    _amplitudeSubscription = null;

    await _recorder.stop();

    if (!mounted) return;

    setState(() {
      _microfoneAtivo = false;
      _nota = '—';
      _frequencia = 0;
      _confianca = '—';
    });
  }

  String _notaPorFrequencia(double frequencia) {
    if (frequencia <= 0) return '—';

    const nomes = [
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

    final numeroMidi =
        69 + 12 * (log(frequencia / 440) / log(2));

    final indice = numeroMidi.round() % 12;

    return nomes[indice];
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
            _microfoneAtivo ? Icons.mic : Icons.mic_none,
            size: 90,
            color: _microfoneAtivo
                ? Colors.redAccent
                : Colors.blueAccent,
          ),

          const SizedBox(height: 20),

          const Text(
            'Descubra o tom da música',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            _microfoneAtivo
                ? '🎤 Ouvindo... cante uma nota da música.'
                : 'Cante uma música a capella para analisar.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: _alternarMicrofone,
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
              padding: const EdgeInsets.all(18),
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
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Frequência: ${_frequencia.toStringAsFixed(1)} Hz',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Confiança: $_confianca',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Tom provável: —',
                    style: TextStyle(fontSize: 18),
                  ),

                  const Text(
                    'Maior / menor: —',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            '💡 Dica: cante notas longas e claras para melhorar a análise.',
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