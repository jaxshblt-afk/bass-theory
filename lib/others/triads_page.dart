import 'package:flutter/material.dart';

import 'triad_fretboard/triad_fretboard_page.dart';

class TriadsPage extends StatelessWidget {
  const TriadsPage({super.key});

  void _abrirTriade(
    BuildContext context,
    String nome,
    String cifra,
    List<String> notas,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TriadFretboardPage(
          nome: nome,
          cifra: cifra,
          notasTriade: notas,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 Tríades'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'TRÍADES',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Estruturas formadas por três notas. '
            'Estude suas fórmulas e visualize as notas '
            'no braço do contrabaixo.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _triade(
            context,
            'Maior',
            '1 • 3 • 5',
            'C',
            ['C', 'E', 'G'],
          ),

          _triade(
            context,
            'Menor',
            '1 • ♭3 • 5',
            'Cm',
            ['C', 'D#', 'G'],
          ),

          _triade(
            context,
            'Diminuta',
            '1 • ♭3 • ♭5',
            'Cdim',
            ['C', 'D#', 'F#'],
          ),

          _triade(
            context,
            'Aumentada',
            '1 • 3 • ♯5',
            'Caug',
            ['C', 'E', 'G#'],
          ),
        ],
      ),
    );
  }

  Widget _triade(
    BuildContext context,
    String nome,
    String estrutura,
    String cifra,
    List<String> notas,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        title: Text(
          nome,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            '$estrutura\nExemplo: $cifra',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),

        onTap: () {
          _abrirTriade(
            context,
            nome,
            cifra,
            notas,
          );
        },
      ),
    );
  }
}