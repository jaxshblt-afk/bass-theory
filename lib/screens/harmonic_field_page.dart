import 'package:flutter/material.dart';

class HarmonicFieldPage extends StatefulWidget {
  const HarmonicFieldPage({super.key});

  @override
  State<HarmonicFieldPage> createState() => _HarmonicFieldPageState();
}

class _HarmonicFieldPageState extends State<HarmonicFieldPage> {
  String tonalidade = 'C';
  bool menor = false;

  final tonalidades = [
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

  final camposMaiores = {
    'C': ['C', 'Dm', 'Em', 'F', 'G', 'Am', 'B°'],
    'C#': ['C#', 'D#m', 'Fm', 'F#', 'G#', 'A#m', 'C°'],
    'D': ['D', 'Em', 'F#m', 'G', 'A', 'Bm', 'C#°'],
    'Eb': ['Eb', 'Fm', 'Gm', 'Ab', 'Bb', 'Cm', 'D°'],
    'E': ['E', 'F#m', 'G#m', 'A', 'B', 'C#m', 'D#°'],
    'F': ['F', 'Gm', 'Am', 'Bb', 'C', 'Dm', 'E°'],
    'F#': ['F#', 'G#m', 'A#m', 'B', 'C#', 'D#m', 'E#°'],
    'G': ['G', 'Am', 'Bm', 'C', 'D', 'Em', 'F#°'],
    'Ab': ['Ab', 'Bbm', 'Cm', 'Db', 'Eb', 'Fm', 'G°'],
    'A': ['A', 'Bm', 'C#m', 'D', 'E', 'F#m', 'G#°'],
    'Bb': ['Bb', 'Cm', 'Dm', 'Eb', 'F', 'Gm', 'A°'],
    'B': ['B', 'C#m', 'D#m', 'E', 'F#', 'G#m', 'A#°'],
  };

  final camposMenores = {
    'C': ['Cm', 'D°', 'Eb', 'Fm', 'Gm', 'Ab', 'Bb'],
    'C#': ['C#m', 'D#°', 'E', 'F#m', 'G#m', 'A', 'B'],
    'D': ['Dm', 'E°', 'F', 'Gm', 'Am', 'Bb', 'C'],
    'Eb': ['Ebm', 'F°', 'Gb', 'Abm', 'Bbm', 'Cb', 'Db'],
    'E': ['Em', 'F#°', 'G', 'Am', 'Bm', 'C', 'D'],
    'F': ['Fm', 'G°', 'Ab', 'Bbm', 'Cm', 'Db', 'Eb'],
    'F#': ['F#m', 'G#°', 'A', 'Bm', 'C#m', 'D', 'E'],
    'G': ['Gm', 'A°', 'Bb', 'Cm', 'Dm', 'Eb', 'F'],
    'Ab': ['Abm', 'Bb°', 'Cb', 'Dbm', 'Ebm', 'Fb', 'Gb'],
    'A': ['Am', 'B°', 'C', 'Dm', 'Em', 'F', 'G'],
    'Bb': ['Bbm', 'C°', 'Db', 'Ebm', 'Fm', 'Gb', 'Ab'],
    'B': ['Bm', 'C#°', 'D', 'Em', 'F#m', 'G', 'A'],
  };

  final graus = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
  ];

  final nomesMaior = [
    'Tônica',
    'Supertônica',
    'Mediante',
    'Subdominante',
    'Dominante',
    'Submediante',
    'Sensível',
  ];

  final nomesMenor = [
    'Tônica',
    'Supertônica',
    'Mediante',
    'Subdominante',
    'Dominante',
    'Submediante',
    'Subtônica',
  ];

  final funcoesMaior = [
    'Tônica',
    'Pré-dominante',
    'Tônica',
    'Subdominante',
    'Dominante',
    'Tônica',
    'Dominante',
  ];

  final funcoesMenor = [
    'Tônica',
    'Pré-dominante',
    'Tônica',
    'Subdominante',
    'Dominante',
    'Submediante',
    'Subtônica',
  ];

  final sensacoesMaior = [
    'Repouso',
    'Preparação',
    'Cor',
    'Movimento',
    'Tensão',
    'Suavidade',
    'Forte tensão',
  ];

  final sensacoesMenor = [
    'Repouso',
    'Tensão',
    'Cor',
    'Movimento',
    'Tensão',
    'Suavidade',
    'Movimento',
  ];

  @override
  Widget build(BuildContext context) {
    final acordes = menor
        ? camposMenores[tonalidade]!
        : camposMaiores[tonalidade]!;

    final nomes = menor ? nomesMenor : nomesMaior;
    final funcoes = menor ? funcoesMenor : funcoesMaior;
    final sensacoes = menor ? sensacoesMenor : sensacoesMaior;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎼 Campo Harmônico'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'CAMPO HARMÔNICO',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Escolha a tonalidade e alterne entre maior e menor.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tonalidade',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    value: tonalidade,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.music_note),
                    ),
                    items: tonalidades.map((tom) {
                      return DropdownMenuItem(
                        value: tom,
                        child: Text(
                          '$tom ${menor ? 'menor' : 'maior'}',
                        ),
                      );
                    }).toList(),
                    onChanged: (valor) {
                      if (valor == null) return;

                      setState(() {
                        tonalidade = valor;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Tipo',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment<bool>(
                        value: false,
                        label: Text('Maior'),
                        icon: Icon(Icons.wb_sunny),
                      ),
                      ButtonSegment<bool>(
                        value: true,
                        label: Text('Menor'),
                        icon: Icon(Icons.nightlight_round),
                      ),
                    ],
                    selected: {menor},
                    onSelectionChanged: (selection) {
                      setState(() {
                        menor = selection.first;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Text(
                    'Campo Harmônico de',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '$tonalidade ${menor ? 'menor' : 'maior'}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    acordes.join('  •  '),
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

          const SizedBox(height: 20),

          ...List.generate(7, (index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    graus[index],
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
                        fontSize: 22,
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
                    'Função: ${funcoes[index]} • ${sensacoes[index]}',
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 10),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📚 Fórmula',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    menor
                        ? 'Menor natural: I • II° • III • IV • V • VI • VII'
                        : 'Maior: I • II • III • IV • V • VI • VII',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    menor
                        ? 'menor • diminuto • maior • menor • menor • maior • maior'
                        : 'maior • menor • menor • maior • maior • menor • diminuto',
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}