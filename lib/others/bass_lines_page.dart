import 'package:flutter/material.dart';

class BassLinesPage extends StatelessWidget {
  const BassLinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 Construção de Linhas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'CONSTRUÇÃO DE LINHAS DE BAIXO',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Aprenda os principais conceitos para criar '
            'linhas de baixo musicais e eficientes.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _topico(
            '🎯 Tônica',
            'Comece pela nota fundamental do acorde '
            'para estabelecer a base harmônica.',
          ),

          _topico(
            '🎼 Notas do acorde',
            'Use 3ª, 5ª e 7ª para acompanhar a harmonia '
            'e deixar a linha mais musical.',
          ),

          _topico(
            '↗️ Aproximação cromática',
            'Use notas vizinhas para criar movimento '
            'em direção à próxima nota importante.',
          ),

          _topico(
            '🎵 Escalas',
            'Utilize notas da escala da música para '
            'construir linhas coerentes.',
          ),

          _topico(
            '🥁 Ritmo',
            'Uma boa linha de baixo depende tanto do ritmo '
            'quanto das notas escolhidas.',
          ),

          _topico(
            '🔄 Repetição e variação',
            'Repita ideias musicais e faça pequenas '
            'variações para criar identidade.',
          ),

          _topico(
            '🎸 Oitavas',
            'Use a mesma nota em regiões diferentes '
            'para criar movimento e impacto.',
          ),

          _topico(
            '🎶 Condução de vozes',
            'Procure caminhos suaves entre as notas '
            'dos acordes.',
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
                    'Comece simples. Uma boa linha de baixo '
                    'não precisa ter muitas notas. O mais '
                    'importante é combinar harmonia e ritmo.',
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

  Widget _topico(
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