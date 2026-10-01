import 'dart:async';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class TunerPage extends StatefulWidget {
  const TunerPage({super.key});

  @override
  State<TunerPage> createState() => _TunerPageState();
}

class _TunerPageState extends State<TunerPage> {
  final AudioRecorder _recorder = AudioRecorder();

  StreamSubscription<List<int>>? _audioSubscription;

  bool _microfoneAtivo = false;
  int _bytesRecebidos = 0;

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

      _audioSubscription = stream.listen((data) {
        if (!mounted) return;

        setState(() {
          _bytesRecebidos = data.length;
        });

        debugPrint('Áudio recebido: ${data.length} bytes');
      });

      setState(() {
        _microfoneAtivo = true;
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

  Future<void> _desativarMicrofone() async {
    await _audioSubscription?.cancel();
    _audioSubscription = null;

    await _recorder.stop();

    if (!mounted) return;

    setState(() {
      _microfoneAtivo = false;
      _bytesRecebidos = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎛️ Afinador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'AFINADOR DE CONTRABAIXO',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            Text(
              _microfoneAtivo ? '🎤' : '—',
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            Text(
              _microfoneAtivo
                  ? 'Microfone ativo'
                  : 'Nenhum som detectado',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 35),

            LinearProgressIndicator(
              value: _microfoneAtivo
                  ? (_bytesRecebidos > 0 ? 1.0 : 0.2)
                  : 0.0,
              minHeight: 12,
            ),

            const SizedBox(height: 15),

            Text(
              _microfoneAtivo
                  ? 'Áudio recebido'
                  : '0 Hz',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 35),

            ElevatedButton.icon(
              onPressed: _microfoneAtivo
                  ? _desativarMicrofone
                  : _ativarMicrofone,
              icon: Icon(
                _microfoneAtivo ? Icons.stop : Icons.mic,
              ),
              label: Text(
                _microfoneAtivo
                    ? 'DESATIVAR MICROFONE'
                    : 'ATIVAR MICROFONE',
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Afinação padrão',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'E  •  A  •  D  •  G',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}