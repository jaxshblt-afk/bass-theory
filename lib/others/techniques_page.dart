import 'package:flutter/material.dart';

class TechniquesPage extends StatelessWidget {
  const TechniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤘 Técnicas de Contrabaixo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'TÉCNICAS DE CONTRABAIXO',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Conheça técnicas importantes para desenvolver '
            'sua sonoridade, velocidade e controle no baixo.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _tecnica(
            '👆 Dedilhado',
            'Toque alternando os dedos indicador e médio '
            'da mão direita para criar precisão e velocidade.',
          ),

          _tecnica(
            '👍 Polegar',
            'Utilize o polegar para tocar as cordas, '
            'produzindo um som forte e definido.',
          ),

          _tecnica(
            '🥁 Slap',
            'Percuta as cordas com o polegar e combine '
            'com outras técnicas para criar o som característico.',
          ),

          _tecnica(
            '🤏 Pop',
            'Puxe a corda com os dedos para produzir '
            'um ataque mais brilhante e percussivo.',
          ),

          _tecnica(
            '🔇 Muting',
            'Abafe as cordas que não estão sendo tocadas '
            'para evitar ruídos indesejados.',
          ),

          _tecnica(
            '🎵 Hammer-on',
            'Toque uma nota e pressione outra nota '
            'com a mão esquerda sem atacar novamente a corda.',
          ),

          _tecnica(
            '🎵 Pull-off',
            'Retire o dedo de uma nota para fazer '
            'a corda soar em uma nota mais grave.',
          ),

          _tecnica(
            '↔️ Slide',
            'Deslize o dedo de uma casa para outra '
            'mantendo a corda pressionada.',
          ),

          _tecnica(
            '🎸 Vibrato',
            'Movimente levemente o dedo sobre a nota '
            'para criar uma variação expressiva de afinação.',
          ),

          _tecnica(
            '⚡ Tapping',
            'Use os dedos da mão direita sobre o braço '
            'para produzir notas sem precisar palhetar ou dedilhar.',
          ),

          const SizedBox(height: 15),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Text(
                    '💡 DICA',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Comece devagar e priorize precisão e '
                    'limpeza. A velocidade vem naturalmente '
                    'com a prática.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tecnica(
    String titulo,
    String descricao,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              descricao,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}