import 'package:flutter/material.dart';

import 'triad_fretboard_widgets.dart';
import 'triad_fretboard_models.dart';

class TriadFretboardPage extends StatefulWidget {
  final String nome;
  final String cifra;
  final List<String> notasTriade;

  const TriadFretboardPage({
    super.key,
    required this.nome,
    required this.cifra,
    required this.notasTriade,
  });

  @override
  State<TriadFretboardPage> createState() =>
      _TriadFretboardPageState();
}

class _TriadFretboardPageState
    extends State<TriadFretboardPage> {
  String? cordaSelecionada;
  int? casaSelecionada;
  String? notaSelecionada;

  bool mostrarMao = true;
  double opacidadeMao = 0.75;

  void selecionarCasa(String corda, int casa, String nota) {
    setState(() {
      cordaSelecionada = corda;
      casaSelecionada = casa;
      notaSelecionada = nota;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎸 Tríades no Contrabaixo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.nome,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Cifra: ${widget.cifra}',
              style: const TextStyle(
                fontSize: 17,
                color: Colors.amberAccent,
              ),
            ),
            const SizedBox(height: 16),
            _cartaoTriade(),
            const SizedBox(height: 16),
            _cartaoNotaSelecionada(),
            const SizedBox(height: 16),
            _cartaoControles(),
            const SizedBox(height: 20),
            const Text(
              'BRAÇO DO CONTRABAIXO',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TriadFretboardWidget(
              notasTriade: widget.notasTriade,
              cordaSelecionada: cordaSelecionada,
              casaSelecionada: casaSelecionada,
              mostrarMao: mostrarMao,
              opacidadeMao: opacidadeMao,
              onSelecionarCasa: selecionarCasa,
            ),
            const SizedBox(height: 16),
            _cartaoLegenda(),
          ],
        ),
      ),
    );
  }

  Widget _cartaoTriade() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notas da tríade',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                widget.notasTriade.length,
                (index) {
                  final nota = widget.notasTriade[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? Colors.blueAccent.withOpacity(0.25)
                          : Colors.orange.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: index == 0
                            ? Colors.blueAccent
                            : Colors.orangeAccent,
                      ),
                    ),
                    child: Text(
                      nota,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartaoNotaSelecionada() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              child: Text(
                notaSelecionada ?? '—',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nota selecionada',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notaSelecionada == null
                        ? 'Toque em uma casa do braço'
                        : '$notaSelecionada • Corda '
                            '$cordaSelecionada • Casa '
                            '$casaSelecionada',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartaoControles() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mostrar posições dos dedos'),
              value: mostrarMao,
              onChanged: (valor) {
                setState(() {
                  mostrarMao = valor;
                });
              },
            ),
            const SizedBox(height: 8),
            const Text('Transparência das posições'),
            Slider(
              value: opacidadeMao,
              min: 0.1,
              max: 1,
              divisions: 9,
              label: '${(opacidadeMao * 100).round()}%',
              onChanged: (valor) {
                setState(() {
                  opacidadeMao = valor;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartaoLegenda() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Legenda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _itemLegenda(
              Colors.lightBlueAccent,
              'Tônica',
            ),
            _itemLegenda(
              Colors.orangeAccent,
              'Outras notas da tríade',
            ),
            _itemLegenda(
              Colors.greenAccent,
              'Casa selecionada',
            ),
            _itemLegenda(
              Colors.cyanAccent,
              'Posições sugeridas dos dedos',
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemLegenda(Color cor, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: cor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(texto)),
        ],
      ),
    );
  }
}
