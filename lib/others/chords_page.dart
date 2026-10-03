import 'package:flutter/material.dart';

class ChordsPage extends StatelessWidget {
  const ChordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎹 Acordes e Cifras'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'ACORDES E CIFRAS',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Aprenda como os acordes são formados '
            'e como interpretar suas cifras.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _acorde(
            context,
            'Maior',
            '1 • 3 • 5',
            'C',
          ),

          _acorde(
            context,
            'Menor',
            '1 • ♭3 • 5',
            'Cm',
          ),

          _acorde(
            context,
            'Dominante',
            '1 • 3 • 5 • ♭7',
            'C7',
          ),

          _acorde(
            context,
            'Maior com 7ª maior',
            '1 • 3 • 5 • 7',
            'Cmaj7',
          ),

          _acorde(
            context,
            'Menor com 7ª menor',
            '1 • ♭3 • 5 • ♭7',
            'Cm7',
          ),

          _acorde(
            context,
            'Suspenso',
            '1 • 4 • 5',
            'Csus4',
          ),

          _acorde(
            context,
            'Diminuto',
            '1 • ♭3 • ♭5',
            'Cdim',
          ),

          _acorde(
            context,
            'Aumentado',
            '1 • 3 • ♯5',
            'Caug',
          ),
        ],
      ),
    );
  }

  Widget _acorde(
    BuildContext context,
    String nome,
    String estrutura,
    String cifra,
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$nome — visualização no braço em breve.',
              ),
            ),
          );
        },
      ),
    );
  }
}