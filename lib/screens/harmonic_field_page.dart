import 'package:flutter/material.dart';

class HarmonicFieldPage extends StatelessWidget {
  const HarmonicFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    const degrees = [
      ['I', 'Tônica', 'Repouso'],
      ['II', 'Supertônica', 'Preparação'],
      ['III', 'Mediante', 'Cor'],
      ['IV', 'Subdominante', 'Movimento'],
      ['V', 'Dominante', 'Tensão'],
      ['VI', 'Submediante', 'Suavidade'],
      ['VII', 'Sensível', 'Tensão'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎼 Campo Harmônico'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: degrees.map((degree) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(degree[0]),
              ),
              title: Text(
                degree[1],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Sensação: ${degree[2]}',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}