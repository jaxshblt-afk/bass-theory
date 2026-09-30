import 'package:flutter/material.dart';

class ModesPage extends StatelessWidget {
  const ModesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const modes = [
      ['Jônio', 'Maior', 'Estável e brilhante'],
      ['Dórico', 'Menor', 'Menor com 6ª maior'],
      ['Frígio', 'Menor', 'Escuro e tenso'],
      ['Lídio', 'Maior', 'Aberto e brilhante'],
      ['Mixolídio', 'Maior', 'Dominante'],
      ['Eólio', 'Menor', 'Melancólico'],
      ['Lócrio', 'Menor', 'Instável e tenso'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎶 Escalas e Modos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: modes.map((mode) {
          return Card(
            child: ListTile(
              title: Text(
                mode[0],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                '${mode[1]} • ${mode[2]}',
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}