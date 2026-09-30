import 'package:flutter/material.dart';

void main() {
  runApp(const BassTheoryApp());
}

class BassTheoryApp extends StatelessWidget {
  const BassTheoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bass Theory',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101218),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const BassHomePage(),
    );
  }
}

class DegreeInfo {
  final String degree;
  final String roman;
  final String sensation;
  final String function;

  const DegreeInfo({
    required this.degree,
    required this.roman,
    required this.sensation,
    required this.function,
  });
}

class BassHomePage extends StatefulWidget {
  const BassHomePage({super.key});

  @override
  State<BassHomePage> createState() => _BassHomePageState();
}

class _BassHomePageState extends State<BassHomePage> {
  final List<String> keys = [
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

  final List<String> sharpNotes = [
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

  final List<String> flatNotes = [
    'C',
    'Db',
    'D',
    'Eb',
    'E',
    'F',
    'Gb',
    'G',
    'Ab',
    'A',
    'Bb',
    'B',
  ];

  String selectedKey = 'C';
  bool isMinor = false;

  int get rootIndex => sharpNotes.indexOf(
        flatToSharp(selectedKey),
      );

  String flatToSharp(String note) {
    const conversion = {
      'Db': 'C#',
      'Eb': 'D#',
      'Gb': 'F#',
      'Ab': 'G#',
      'Bb': 'A#',
    };

    return conversion[note] ?? note;
  }

  List<String> get scaleNotes {
    final intervals = isMinor
        ? [0, 2, 3, 5, 7, 8, 10]
        : [0, 2, 4, 5, 7, 9, 11];

    final useFlats = selectedKey.contains('b');

    return intervals.map((interval) {
      final index = (rootIndex + interval) % 12;
      return useFlats ? flatNotes[index] : sharpNotes[index];
    }).toList();
  }

  List<DegreeInfo> get degrees {
    if (!isMinor) {
      return const [
        DegreeInfo(
          degree: 'Tônica',
          roman: 'I',
          sensation: 'Repouso e estabilidade',
          function: 'Centro tonal',
        ),
        DegreeInfo(
          degree: 'Supertônica',
          roman: 'II',
          sensation: 'Movimento e preparação',
          function: 'Predominante',
        ),
        DegreeInfo(
          degree: 'Mediante',
          roman: 'III',
          sensation: 'Define o caráter maior',
          function: 'Cor da tonalidade',
        ),
        DegreeInfo(
          degree: 'Subdominante',
          roman: 'IV',
          sensation: 'Abertura e movimento',
          function: 'Predominante',
        ),
        DegreeInfo(
          degree: 'Dominante',
          roman: 'V',
          sensation: 'Forte tensão',
          function: 'Tensão e resolução',
        ),
        DegreeInfo(
          degree: 'Submediante',
          roman: 'VI',
          sensation: 'Expressão e suavidade',
          function: 'Relativa',
        ),
        DegreeInfo(
          degree: 'Sensível',
          roman: 'VII',
          sensation: 'Máxima tendência para a tônica',
          function: 'Tensão',
        ),
      ];
    }

    return const [
      DegreeInfo(
        degree: 'Tônica',
        roman: 'I',
        sensation: 'Repouso e estabilidade',
        function: 'Centro tonal',
      ),
      DegreeInfo(
        degree: 'Supertônica',
        roman: 'II',
        sensation: 'Movimento e tensão',
        function: 'Predominante',
      ),
      DegreeInfo(
        degree: 'Mediante',
        roman: 'III',
        sensation: 'Cor menor',
        function: 'Característica',
      ),
      DegreeInfo(
        degree: 'Subdominante',
        roman: 'IV',
        sensation: 'Abertura',
        function: 'Predominante',
      ),
      DegreeInfo(
        degree: 'Dominante',
        roman: 'V',
        sensation: 'Tensão',
        function: 'Dominante',
      ),
      DegreeInfo(
        degree: 'Submediante',
        roman: 'VI',
        sensation: 'Cor e movimento',
        function: 'Relativa',
      ),
      DegreeInfo(
        degree: 'Subtônica',
        roman: 'VII',
        sensation: 'Menor tendência para a tônica',
        function: 'Movimento',
      ),
    ];
  }

  int noteIndex(String note) {
    return sharpNotes.indexOf(flatToSharp(note));
  }

  String bassNoteAt(int stringIndex, int fret) {
    // Afinação padrão do baixo de 4 cordas:
    // E - A - D - G
    final openStrings = [4, 9, 2, 7];
    final index = (openStrings[stringIndex] + fret) % 12;

    final useFlats = selectedKey.contains('b');

    return useFlats ? flatNotes[index] : sharpNotes[index];
  }

  bool isScaleNote(String note) {
    return scaleNotes.contains(note);
  }

  @override
  Widget build(BuildContext context) {
    final notes = scaleNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BASS THEORY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Campo musical para contrabaixo',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Selecione o tom e veja as notas, graus, funções e sensações.',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 22),

          // SELETOR DE TOM
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TONALIDADE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: selectedKey,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tom',
                    ),
                    items: keys.map((key) {
                      return DropdownMenuItem(
                        value: key,
                        child: Text(key),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedKey = value;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 15),

                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(
                        value: false,
                        label: Text('MAIOR'),
                        icon: Icon(Icons.wb_sunny),
                      ),
                      ButtonSegment(
                        value: true,
                        label: Text('MENOR'),
                        icon: Icon(Icons.nightlight),
                      ),
                    ],
                    selected: {isMinor},
                    onSelectionChanged: (value) {
                      setState(() {
                        isMinor = value.first;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // RESUMO
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${selectedKey} ${isMinor ? 'menor' : 'maior'}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Escala:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    children: notes.asMap().entries.map((entry) {
                      final i = entry.key;
                      final note = entry.value;

                      return Chip(
                        label: Text(
                          '${i + 1}. $note',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'GRAUS E SENSAÇÕES',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // GRAUS
          ...degrees.asMap().entries.map((entry) {
            final index = entry.key;
            final info = entry.value;
            final note = notes[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    info.roman,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  '$note — ${info.degree}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${info.function}\n${info.sensation}',
                ),
                isThreeLine: true,
              ),
            );
          }),

          const SizedBox(height: 12),

          const Text(
            'BRAÇO DO BAIXO',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Afinação padrão: E - A - D - G',
          ),

          const SizedBox(height: 10),

          // BRAÇO
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 38),

                    ...List.generate(
                      13,
                      (fret) => SizedBox(
                        width: 62,
                        child: Text(
                          '$fret',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ...List.generate(4, (stringIndex) {
                  final stringNames = ['E', 'A', 'D', 'G'];

                  return Row(
                    children: [
                      SizedBox(
                        width: 38,
                        child: Text(
                          stringNames[stringIndex],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      ...List.generate(13, (fret) {
                        final note =
                            bassNoteAt(stringIndex, fret);

                        final selected =
                            isScaleNote(note);

                        final tonic =
                            note == selectedKey;

                        return Container(
                          width: 62,
                          height: 46,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade700,
                            ),
                            borderRadius:
                                BorderRadius.circular(5),
                            color: tonic
                                ? Colors.blue.withOpacity(0.8)
                                : selected
                                    ? Colors.blue.withOpacity(0.25)
                                    : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              note,
                              style: TextStyle(
                                fontWeight: selected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Tônica'),

                  const SizedBox(width: 20),

                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Notas da escala'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Center(
            child: Text(
              'Bass Theory • Desenvolvido para contrabaixo',
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}