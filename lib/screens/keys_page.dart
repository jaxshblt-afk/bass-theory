import 'package:flutter/material.dart';

class KeysPage extends StatelessWidget {
  const KeysPage({super.key});

  @override
  Widget build(BuildContext context) {
    const keys = [
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

    const relativeMinors = [
      'Am',
      'A#m',
      'Bm',
      'Cm',
      'C#m',
      'Dm',
      'D#m',
      'Em',
      'Fm',
      'F#m',
      'Gm',
      'G#m',
    ];

    const scales = [
      'C • D • E • F • G • A • B',
      'C# • D# • F • F# • G# • A# • C',
      'D • E • F# • G • A • B • C#',
      'Eb • F • G • Ab • Bb • C • D',
      'E • F# • G# • A • B • C# • D#',
      'F • G • A • Bb • C • D • E',
      'F# • G# • A# • B • C# • D# • F',
      'G • A • B • C • D • E • F#',
      'Ab • Bb • C • Db • Eb • F • G',
      'A • B • C# • D • E • F# • G#',
      'Bb • C • D • Eb • F • G • A',
      'B • C# • D# • E • F# • G# • A#',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 Tonalidades'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: keys.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        '🎵 ${keys[index]} maior',
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Escala maior',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(scales[index]),

                          const SizedBox(height: 20),

                          const Text(
                            'Menor relativa',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(relativeMinors[index]),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('FECHAR'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Center(
                child: Text(
                  keys[index],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}