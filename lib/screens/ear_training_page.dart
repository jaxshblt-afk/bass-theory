import 'package:flutter/material.dart';

import '../services/ear_training_service.dart';

class EarTrainingPage extends StatefulWidget {
  const EarTrainingPage({super.key});

  @override
  State<EarTrainingPage> createState() =>
      _EarTrainingPageState();
}

class _EarTrainingPageState
    extends State<EarTrainingPage> {
  final EarTrainingService _service =
      EarTrainingService();

  late EarTrainingQuestion _pergunta;

  int _acertos = 0;
  int _erros = 0;

  String _resultado = 'Escolha a nota que você ouviu.';
  bool _respondido = false;

  @override
  void initState() {
    super.initState();
    _novaPergunta();
  }

  void _novaPergunta() {
    setState(() {
      _pergunta = _service.gerarPergunta();
      _resultado =
          'Escolha a nota que você ouviu.';
      _respondido = false;
    });
  }

  void _responder(String resposta) {
    if (_respondido) return;

    final acertou =
        _service.verificarResposta(
      _pergunta,
      resposta,
    );

    setState(() {
      _respondido = true;

      if (acertou) {
        _acertos++;
        _resultado =
            '✅ Acertou! A nota era ${_pergunta.nota}.';
      } else {
        _erros++;
        _resultado =
            '❌ Errou! A nota era ${_pergunta.nota}.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👂 Treino de Ouvido'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          const Icon(
            Icons.hearing,
            size: 90,
            color: Colors.blueAccent,
          ),

          const SizedBox(height: 20),

          const Text(
            'TREINO DE OUVIDO',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Ouça a nota e tente identificar qual é.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 30),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Qual nota você ouviu?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.volume_up,
                    ),
                    label: const Text(
                      'OUVIR NOTA',
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          ..._pergunta.opcoes.map(
            (opcao) {
              return Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 10,
                ),
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      _responder(opcao);
                    },
                    child: Text(
                      opcao,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 15),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Text(
                    _resultado,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceEvenly,
                    children: [
                      Text(
                        '✅ Acertos: $_acertos',
                        style:
                            const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '❌ Erros: $_erros',
                        style:
                            const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          if (_respondido)
            ElevatedButton.icon(
              onPressed: _novaPergunta,
              icon: const Icon(
                Icons.refresh,
              ),
              label: const Text(
                'PRÓXIMA NOTA',
              ),
            ),

          const SizedBox(height: 20),

          const Text(
            '💡 Tente responder sem olhar para o braço do instrumento.',
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