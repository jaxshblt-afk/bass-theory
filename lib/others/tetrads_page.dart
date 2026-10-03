import 'package:flutter/material.dart';

import 'tetrad_fretboard_page.dart';

class TetradsPage extends StatelessWidget {
  const TetradsPage({super.key});

  void _abrirTetrade(
    BuildContext context,
    String nome,
    String cifra,
    List<String> notas,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TetradFretboardPage(
          nome: nome,
          cifra: cifra,
          notasTetrade: notas,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎼 Tétrades'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'TÉTRADES',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Acordes formados por quatro notas. '
            'Toque em uma tétrade para visualizar '
            'suas notas no braço do contrabaixo.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _tetrade(
            context,
            'Maior com 7ª maior',
            '1 • 3 • 5 • 7',
            'Cmaj7',
            ['C', 'E', 'G', 'B'],
          ),

          _tetrade(
            context,
            'Dominante',
            '1 • 3 • 5 • ♭7',
            'C7',
            ['C', 'E', 'G', 'A#'],
          ),

          _tetrade(
            context,
            'Menor com 7ª menor',
            '1 • ♭3 • 5 • ♭7',
            'Cm7',
            ['C', 'D#', 'G', 'A#'],
          ),

          _tetrade(
            context,
            'Menor com 7ª maior',
            '1 • ♭3 • 5 • 7',
            'Cm(maj7)',
            ['C', 'D#', 'G', 'B'],
          ),

          _tetrade(
            context,
            'Meio diminuto',
            '1 • ♭3 • ♭5 • ♭7',
            'Cm7♭5',
            ['C', 'D#', 'F#', 'A#'],
          ),

          _tetrade(
            context,
            'Diminuta',
            '1 • ♭3 • ♭5 • ♭♭7',
            'Cdim7',
            ['C', 'D#', 'F#', 'A'],
          ),
        ],
      ),
    );
  }

  Widget _tetrade(
    BuildContext context,
    String nome,
    String estrutura,
    String cifra,
    List<String> notas,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding:
            const EdgeInsets.all(16),

        title: Text(
          nome,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),

        subtitle: Padding(
          padding:
              const EdgeInsets.only(top: 8),
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
          _abrirTetrade(
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