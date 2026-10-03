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
            '/tetrades',
          ),

          _botao(
            context,
            '🎸 Escalas para Contrabaixo',
            'Conheça escalas importantes para o baixo.',
            '/escalas',
          ),

          _botao(
            context,
            '🎹 Acordes e Cifras',
            'Aprenda a interpretar acordes e cifras.',
            '/acordes',
          ),

          _botao(
            context,
            '🎵 Construção de Linhas de Baixo',
            'Aprenda a criar linhas de baixo.',
            '/linhas',
          ),

          _botao(
            context,
            '🥁 Ritmo',
            'Estude divisão rítmica e precisão.',
            '/ritmo',
          ),

          _botao(
            context,
            '🤘 Técnicas de Contrabaixo',
            'Conheça as principais técnicas para tocar baixo.',
            '/tecnicas',
          ),
        ],
      ),
    );
  }

  Widget _botao(
    BuildContext context,
    String titulo,
    String descricao,
    String rota,
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
          Navigator.pushNamed(context, rota);
        },
      ),
    );
  }
}