import 'package:flutter/material.dart';

class TetradsPage extends StatelessWidget {
  const TetradsPage({super.key});

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
            'Estude a estrutura e a aplicação no contrabaixo.',
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
          ),

          _tetrade(
            context,
            'Dominante',
            '1 • 3 • 5 • ♭7',
            'C7',
          ),

          _tetrade(
            context,
            'Menor com 7ª menor',
            '1 • ♭3 • 5 • ♭7',
            'Cm7',
          ),

          _tetrade(
            context,
            'Menor com 7ª maior',
            '1 • ♭3 • 5 • 7',
            'Cm(maj7)',
          ),

          _tetrade(
            context,
            'Meio diminuto',
            '1 • ♭3 • ♭5 • ♭7',
            'Cm7♭5',
          ),

          _tetrade(
            context,
            'Diminuta',
            '1 • ♭3 • ♭5 • ♭♭7',
            'Cdim7',
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
                '$nome — braço interativo em breve.',
              ),
            ),
          );
        },
      ),
    );
  }
}