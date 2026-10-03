import 'package:flutter/material.dart';

class BassScalesPage extends StatelessWidget {
  const BassScalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎸 Escalas para Contrabaixo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'ESCALAS PARA CONTRABAIXO',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Conheça as principais escalas utilizadas '
            'na construção de linhas de baixo.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _escala(
            context,
            'Escala maior',
            '1 • 2 • 3 • 4 • 5 • 6 • 7',
            'C • D • E • F • G • A • B',
          ),

          _escala(
            context,
            'Escala menor natural',
            '1 • 2 • ♭3 • 4 • 5 • ♭6 • ♭7',
            'C • D • Eb • F • G • Ab • Bb',
          ),

          _escala(
            context,
            'Pentatônica maior',
            '1 • 2 • 3 • 5 • 6',
            'C • D • E • G • A',
          ),

          _escala(
            context,
            'Pentatônica menor',
            '1 • ♭3 • 4 • 5 • ♭7',
            'C • Eb • F • G • Bb',
          ),

          _escala(
            context,
            'Escala blues',
            '1 • ♭3 • 4 • ♭5 • 5 • ♭7',
            'C • Eb • F • Gb • G • Bb',
          ),

          _escala(
            context,
            'Escala cromática',
            'Todos os 12 semitons',
            'C • Db • D • Eb • E • F • Gb • G • Ab • A • Bb • B',
          ),
        ],
      ),
    );
  }

  Widget _escala(
    BuildContext context,
    String nome,
    String estrutura,
    String exemplo,
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
            '$estrutura\nExemplo em C: $exemplo',
            style: const TextStyle(
              fontSize: 15,
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