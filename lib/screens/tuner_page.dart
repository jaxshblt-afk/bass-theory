import 'dart:async';
import 'dart:math';
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

  double _frequencia = 0;
  String _nota = '—';
  String _status = 'Nenhum som detectado';

  DateTime? _ultimoSom;

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

      setState(() {
        _microfoneAtivo = true;
        _status = 'Ouvindo...';
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

    // Mantém boa sensibilidade.
    if (energia < 100) {
      _manterUltimaLeitura();
      return;
    }

    final frequencia = _detectarFrequencia(
      samples,
      44100,
    );

    if (frequencia <= 0) {
      _manterUltimaLeitura();
      return;
    }

    // Aceita somente a região das cordas do contrabaixo.
    if (frequencia < 35 || frequencia > 115) {
      return;
    }

    final resultado = _encontrarNota(frequencia);

    // Guarda a frequência.
    _leituras.add(frequencia);

    // Mantém somente as últimas 8 leituras.
    if (_leituras.length > 8) {
      _leituras.removeAt(0);
    }

    // Média das leituras.
    double media = 0;

    for (final valor in _leituras) {
      media += valor;
    }

    media /= _leituras.length;

    final resultadoMedia = _encontrarNota(media);

    // Filtro de troca de nota.
    if (_notaEstavel == resultadoMedia.nota) {
      _contadorNota++;
    } else {
      _notaEstavel = resultadoMedia.nota;
      _contadorNota = 1;
    }

    // Só troca a nota exibida depois de algumas leituras
    // consecutivas confirmando a mesma nota.
    if (_contadorNota < 3) {
      _ultimoSom = DateTime.now();
      return;
    }

    _ultimoSom = DateTime.now();

    if (!mounted) return;

    setState(() {
      _frequencia = media;
      _nota = resultadoMedia.nota;
      _status = resultadoMedia.status;
    });
  }

  void _manterUltimaLeitura() {
    if (_ultimoSom == null) {
      if (!mounted) return;

      setState(() {
        _status = 'Toque uma corda...';
      });

      return;
    }

    final tempo =
        DateTime.now().difference(_ultimoSom!);

    // Mantém a última leitura por 1,5 segundos.
    if (tempo.inMilliseconds > 1500) {
      if (!mounted) return;

      setState(() {
        _frequencia = 0;
        _nota = '—';
        _status = 'Toque uma corda...';
      });

      _leituras.clear();
      _notaEstavel = null;
      _contadorNota = 0;
    }
  }

  double _detectarFrequencia(
    List<double> samples,
    int sampleRate,
  ) {
    const minFreq = 35.0;
    const maxFreq = 115.0;

    final minLag =
        (sampleRate / maxFreq).round();

    final maxLag =
        (sampleRate / minFreq).round();

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

  _Resultado _encontrarNota(double frequencia) {
    const notas = {
      'E': 41.20,
      'A': 55.00,
      'D': 73.42,
      'G': 98.00,
    };

    String melhorNota = '—';
    double melhorFrequencia = 0;
    double menorDiferenca = double.infinity;

    notas.forEach((nome, alvo) {
      final diferenca =
          (frequencia - alvo).abs();

      if (diferenca < menorDiferenca) {
        menorDiferenca = diferenca;
        melhorNota = nome;
        melhorFrequencia = alvo;
      }
    });

    final cents =
        1200 *
        log(frequencia / melhorFrequencia) /
        ln2;

    String status;

    if (cents.abs() <= 5) {
      status = 'AFINADO';
    } else if (cents < 0) {
      status = 'GRAVE — aumente a tensão';
    } else {
      status = 'AGUDO — diminua a tensão';
    }

    return _Resultado(
      nota: melhorNota,
      status: status,
    );
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
    _ultimoSom = null;
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
              _nota,
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            Text(
              _status,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 35),

            LinearProgressIndicator(
              value: _microfoneAtivo ? 0.8 : 0,
              minHeight: 12,
            ),

            const SizedBox(height: 15),

            Text(
              _frequencia > 0
                  ? '${_frequencia.toStringAsFixed(1)} Hz'
                  : '0 Hz',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 35),

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

class _Resultado {
  final String nota;
  final String status;

  _Resultado({
    required this.nota,
    required this.status,
  });
}