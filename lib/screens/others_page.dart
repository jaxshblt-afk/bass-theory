import 'package:flutter/material.dart';

class OthersPage extends StatelessWidget {
  const OthersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Outros'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'OUTROS',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Conteúdos para aprofundar seus conhecimentos no contrabaixo.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _botao(
            context,
            '🎼 Tétrades',
            'Estude acordes de quatro notas.',
          ),

          _botao(
            context,
            '🎸 Escalas para Contrabaixo',
            'Conheça escalas importantes para o baixo.',
          ),

          _botao(
            context,
            '🎹 Acordes e Cifras',
            'Aprenda a interpretar acordes e cifras.',
          ),

          _botao(
            context,
            '🎵 Construção de Linhas de Baixo',
            'Aprenda a criar linhas de baixo.',
          ),

          _botao(
            context,
            '🥁 Ritmo',
            'Estude divisão rítmica e precisão.',
          ),

          _botao(
            context,
            '🤘 Técnicas de Contrabaixo',
            'Conheça as principais técnicas para tocar baixo.',
          ),
        ],
      ),
    );
  }

  Widget _botao(
    BuildContext context,
    String titulo,
    String descricao,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(descricao),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),

        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$titulo em desenvolvimento.',
              ),
            ),
          );
        },
      ),
    );
  }
}