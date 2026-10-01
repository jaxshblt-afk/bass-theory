import 'package:flutter/material.dart';

class HarmonicFieldPage extends StatefulWidget {
  const HarmonicFieldPage({super.key});

  @override
  State<HarmonicFieldPage> createState() => _HarmonicFieldPageState();
}

class _HarmonicFieldPageState extends State<HarmonicFieldPage> {
  String tonalidadeSelecionada = 'C';

  final List<String> tonalidades = [
    'C',
    'C#',
    'D',
    'Eb',
    'E',
    'F',
    'F#',
    'G',
    'Ab',
    'A',
    'Bb',
    'B',
  ];

  final List<String> notas = [
    'C',
    'C#',
    'D',
    'Eb',
    'E',
    'F',
    'F#',
    'G',
    'Ab',
    'A',
    'Bb',
    'B',
  ];

  final List<String> intervalos = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
  ];

  final List<String> nomes = [
    'Tônica',
    'Supertônica',
    'Mediante',
    'Subdominante',
    'Dominante',
    'Submediante',
    'Sensível',
  ];

  final List<String> funcoes = [
    'Tônica',
    'Subdominante',
    'Tônica',
    'Subdominante',
    'Dominante',
    'Tônica',
    'Dominante',
  ];

  final List<String> sensacoes = [
    'Repouso',
    'Preparação',
    'Cor',
    'Movimento',
    'Tensão',
    'Suavidade',
    'Tensão forte',
  ];

  List<String> _montarCampoHarmonico(String tonica) {
    final indice = notas.indexOf(tonica);

    const passos = [
      0,
      2,
      4,
      5,
      7,
      9,
      11,
    ];

    return passos.map((passo) {
      return notas[(indice + passo) % notas.length];
    }).toList();
  }

  List<String> _montarAcordes(String tonica) {
    final campo = _montarCampoHarmonico(tonica);

    return [
      '${campo[0]}',
      '${campo[1]}m',
      '${campo[2]}m',
      '${campo[3]}',
      '${campo[4]}',
      '${campo[5]}m',
      '${campo[6]}°',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final campo = _montarCampoHarmonico(tonalidadeSelecionada);
    final acordes = _montarAcordes(tonalidadeSelecionada);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎼 Campo Harmônico'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'CAMPO HARMÔNICO MAIOR',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Escolha uma tonalidade para visualizar seus acordes e funções harmônicas.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Tonalidade',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: tonalidadeSelecionada,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.music_note),
            ),
            items: tonalidades.map((tonalidade) {
              return DropdownMenuItem(
                value: tonalidade,
                child: Text(
                  '$tonalidade maior',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
            onChanged: (valor) {
              if (valor == null) return;

              setState(() {
                tonalidadeSelecionada = valor;
              });
            },
          ),

          const SizedBox(height: 25),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Text(
                    'Campo Harmônico de',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '$tonalidadeSelecionada maior',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    campo.join('  •  '),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          ...List.generate(7, (index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    intervalos[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                title: Row(
                  children: [
                    Text(
                      acordes[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        nomes[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Função: ${funcoes[index]}  •  Sensação: ${sensacoes[index]}',
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 15),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '💡 Para o baixista',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'O campo harmônico mostra quais acordes pertencem à tonalidade. '
                    'O baixo pode usar essas informações para criar linhas, '
                    'caminhadas e conexões entre os acordes.',
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              'Bass Theory 3.0.0',
              style: TextStyle(
                color: Colors.white38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}