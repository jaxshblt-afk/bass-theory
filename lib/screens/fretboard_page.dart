import 'package:flutter/material.dart';

class FretboardPage extends StatelessWidget {
  const FretboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const strings = ['E', 'A', 'D', 'G'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎸 Braço do Contrabaixo'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 35),
                  ...List.generate(
                    13,
                    (fret) => SizedBox(
                      width: 60,
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

              ...strings.map(
                (string) => Row(
                  children: [
                    SizedBox(
                      width: 35,
                      child: Text(
                        string,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    ...List.generate(
                      13,
                      (fret) => Container(
                        width: 58,
                        height: 48,
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white24,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '•',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}