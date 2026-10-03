import 'package:flutter/material.dart';

class RhythmPage extends StatelessWidget {
  const RhythmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🥁 Ritmo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'RITMO PARA CONTRABAIXO',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Aprenda conceitos rítmicos importantes '
            'para tocar com precisão e groove.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 25),

          _ritmo(
            '♩ Semínima',
            'Uma batida por tempo. É uma das figuras '
            'mais importantes para começar a estudar ritmo.',
          ),

          _ritmo(
            '♪ Colcheia',
            'Duas notas por tempo. Muito utilizada '
            'em grooves de contrabaixo.',
          ),

          _ritmo(
            '𝅘𝅥𝅯 Semicolcheia',
            'Quatro subdivisões por tempo. '
            'Permite criar linhas mais movimentadas.',
          ),

          _ritmo(
            '⏱️ Tempo e BPM',
            'BPM significa batidas por minuto. '
            'Quanto maior o BPM, mais rápido é o andamento.',
          ),

          _ritmo(
            '🎯 Precisão',
            'Procure tocar exatamente junto com o pulso '
            'e mantenha o tempo constante.',
          ),

          _ritmo(
            '🥁 Groove',
            'O groove acontece quando ritmo, dinâmica '
            'e articulação trabalham juntos.',
          ),

          _ritmo(
            '⏸️ Pausas',
            'O silêncio também faz parte da música. '
            'Aprenda a controlar as pausas entre as notas.',
          ),

          const SizedBox(height: 15),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Text(
                    '💡 DICA DE ESTUDO',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Use um metrônomo. Comece devagar e '
                    'aumente o BPM somente quando conseguir '
                    'tocar com precisão.',
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

  Widget _ritmo(
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