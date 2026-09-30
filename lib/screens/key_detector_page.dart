import 'package:flutter/material.dart';

class KeyDetectorPage extends StatelessWidget {
  const KeyDetectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Descobrir o Tom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.mic,
              size: 90,
              color: Colors.blueAccent,
            ),

            const SizedBox(height: 20),

            const Text(
              'Cante uma música a capella',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Cante sem instrumentos e deixe o Bass Theory analisar a tonalidade.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.mic),
              label: const Text('COMEÇAR A OUVIR'),
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: const [
                    Text(
                      'Resultado da análise',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

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
              'O resultado poderá ser mostrado no braço do contrabaixo.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}