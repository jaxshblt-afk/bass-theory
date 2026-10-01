import 'dart:async';
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
  String _status = 'Microfone desligado';

  StreamSubscription<Amplitude>? _amplitudeSubscription;

  @override
  void dispose() {
    _amplitudeSubscription?.cancel();
    _recorder.dispose();
    super.dispose();
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

    try {
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 44100,
          numChannels: 1,
        ),
        path: 'key_detector.wav',
      );

      _amplitudeSubscription = _recorder
          .onAmplitudeChanged(
            const Duration(milliseconds: 200),
          )
          .listen((amplitude) {
        if (!mounted) return;

        setState(() {
          _status = amplitude.current > -50
              ? 'Microfone ouvindo 🎤'
              : 'Aguardando você cantar...';
        });
      });

      if (!mounted) return;

      setState(() {
        _microfoneAtivo = true;
        _status = 'Microfone ouvindo 🎤';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _microfoneAtivo = false;
        _status = 'Erro ao iniciar o microfone';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: $e'),
        ),
      );
    }
  }

  Future<void> _pararMicrofone() async {
    await _amplitudeSubscription?.cancel();
    _amplitudeSubscription = null;

    await _recorder.stop();

    if (!mounted) return;

    setState(() {
      _microfoneAtivo = false;
      _status = 'Microfone desligado';
    });
  }

  Future<void> _alternarMicrofone() async {
    if (_microfoneAtivo) {
      await _pararMicrofone();
    } else {
      await _iniciarMicrofone();
    }
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
            _status,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: _alternarMicrofone,
            icon: Icon(
              _microfoneAtivo ? Icons.stop : Icons.mic,
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
                children: const [
                  Text(
                    'Resultado da análise',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    '—',
                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Tom provável: —',
                    style: TextStyle(fontSize: 18),
                  ),

                  Text(
                    'Tônica: —',
                    style: TextStyle(fontSize: 18),
                  ),

                  Text(
                    'Maior / menor: —',
                    style: TextStyle(fontSize: 18),
                  ),

                  Text(
                    'Confiança: —',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            '💡 Cante uma nota longa e clara para ajudar na análise.',
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