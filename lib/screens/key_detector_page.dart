import 'dart:async';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import '../services/key_detector_service.dart';

class KeyDetectorPage extends StatefulWidget {
  const KeyDetectorPage({super.key});

  @override
  State<KeyDetectorPage> createState() =>
      _KeyDetectorPageState();
}

class _KeyDetectorPageState
    extends State<KeyDetectorPage> {
  final AudioRecorder _recorder =
      AudioRecorder();

  final KeyDetectorService _detector =
      KeyDetectorService();

  StreamSubscription<List<int>>?
      _audioSubscription;

  bool _microfoneAtivo = false;

  double _frequencia = 0;
  String _nota = '—';
  String _status =
      'Nenhum som detectado';

  String _tom = '—';
  String _tipo = '—';
  String _confianca = '—';

  @override
  void dispose() {
    _audioSubscription?.cancel();
    _recorder.stop();
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
    final permitido =
        await _recorder.hasPermission();

    if (!permitido) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Permita o acesso ao microfone.',
          ),
        ),
      );

      return;
    }

    try {
      _detector.limpar();

      final stream =
          await _recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 44100,
          numChannels: 1,
        ),
      );

      await _audioSubscription?.cancel();

      _audioSubscription =
          stream.listen(_analisarAudio);

      if (!mounted) return;

      setState(() {
        _microfoneAtivo = true;
        _status = 'Ouvindo...';
        _nota = '—';
        _frequencia = 0;
        _tom = '—';
        _tipo = '—';
        _confianca = '—';
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao iniciar microfone: $e',
          ),
        ),
      );
    }
  }

  void _analisarAudio(List<int> dados) {
    if (dados.length < 2000) {
      return;
    }

    final samples = <double>[];

    for (int i = 0;
        i + 1 < dados.length;
        i += 2) {
      int valor =
          dados[i] |
          (dados[i + 1] << 8);

      if (valor > 32767) {
        valor -= 65536;
      }

      samples.add(
        valor.toDouble(),
      );
    }

    if (samples.length < 1000) {
      return;
    }

    final frequencia =
        _detector.detectarFrequencia(
      samples,
      44100,
    );

    if (frequencia <= 0) {
      return;
    }

    if (frequencia < 60 ||
        frequencia > 1000) {
      return;
    }

    final nota =
        _detector.encontrarNota(
      frequencia,
    );

    _detector.registrarNota(nota);

    if (_detector.contadorNota < 3) {
      return;
    }

    if (!mounted) return;

    setState(() {
      _frequencia = frequencia;
      _nota = nota;
      _tom = _detector.calcularTom();
      _tipo = _detector.calcularTipo();
      _confianca =
          _detector.calcularConfianca();

      _status = 'Nota detectada';
    });
  }

  Future<void> _pararMicrofone() async {
    await _audioSubscription?.cancel();

    _audioSubscription = null;

    await _recorder.stop();

    _detector.limpar();

    if (!mounted) return;

    setState(() {
      _microfoneAtivo = false;
      _frequencia = 0;
      _nota = '—';
      _status =
          'Nenhum som detectado';
      _tom = '—';
      _tipo = '—';
      _confianca = '—';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('🎤 Descobrir o Tom'),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(20),
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
                ? '🎤 Ouvindo...'
                : 'Cante uma música a capella',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed:
                _alternarMicrofone,
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
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Resultado da análise',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    _tom,
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Colors.blueAccent,
                    ),
                  ),

                  Text(
                    _tipo,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Nota atual: $_nota',
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    _frequencia > 0
                        ? 'Frequência: '
                            '${_frequencia.toStringAsFixed(1)} Hz'
                        : 'Frequência: 0 Hz',
                    style:
                        const TextStyle(
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Confiança: $_confianca',
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    _status,
                    style:
                        const TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            '💡 Cante por alguns segundos '
            'para o aplicativo analisar '
            'as notas e estimar o tom.',
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