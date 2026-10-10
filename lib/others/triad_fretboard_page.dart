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
  double opacidadeMao = 0.22;

  bool fazParteDaTriade(String nota) =>
      widget.notasTriade.contains(nota);

  bool ehTonica(String nota) =>
      widget.notasTriade.isNotEmpty &&
      nota == widget.notasTriade.first;

  void selecionarCasa(
    String corda,
    int casa,
    String nota,
  ) {
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
        title: const Text('Tríades no Braço'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _cartaoTriade(),
            const SizedBox(height: 12),
            _cartaoNotaSelecionada(),
            const SizedBox(height: 12),
            _cartaoControles(),
            const SizedBox(height: 12),
            _cartaoLegenda(),
            const SizedBox(height: 12),
            const Text(
              'Braço do contrabaixo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TriadFretboardWidget(
              notasTriade: widget.notasTriade,
              cordaSelecionada: cordaSelecionada,
              casaSelecionada: casaSelecionada,
              mostrarMao: mostrarMao,
              opacidadeMao: opacidadeMao,
              onSelecionarCasa: selecionarCasa,
            ),
            const SizedBox(height: 12),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Numeração sugerida: 1 = indicador, '
                  '2 = médio, 3 = anelar e 4 = mínimo. '
                  'A digitação pode variar conforme a posição '
                  'e a técnica do contrabaixista.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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
          children: [
            Text(
              widget.nome,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.cifra,
              style: const TextStyle(
                fontSize: 19,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Notas da tríade',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: widget.notasTriade.map((nota) {
                return Chip(
                  label: Text(nota),
                  backgroundColor: ehTonica(nota)
                      ? Colors.blue.shade800
                      : Colors.orange.shade800,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartaoNotaSelecionada() {
    if (notaSelecionada == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Text(
            'Toque em uma casa do braço para selecionar uma nota.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final pertence = fazParteDaTriade(notaSelecionada!);

    return Card(
      color: pertence
          ? Colors.green.shade900
          : Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
              'Nota: $notaSelecionada',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text('Corda: $cordaSelecionada'),
            Text('Casa: $casaSelecionada'),
            const SizedBox(height: 5),
            Text(
              pertence
                  ? (ehTonica(notaSelecionada!)
                      ? 'Tônica da tríade'
                      : 'Nota pertencente à tríade')
                  : 'Nota fora desta tríade',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartaoControles() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mostrar mão no braço'),
              subtitle: const Text(
                'Exibe a mão sobre as notas selecionadas.',
              ),
              value: mostrarMao,
              onChanged: (valor) {
                setState(() => mostrarMao = valor);
              },
            ),
            const Divider(),
            Row(
              children: [
                const Icon(Icons.opacity),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Transparência da mão'),
                ),
                Text('${(opacidadeMao * 100).round()}%'),
              ],
            ),
            Slider(
              value: opacidadeMao,
              min: 0.05,
              max: 0.50,
              divisions: 9,
              label: '${(opacidadeMao * 100).round()}%',
              onChanged: (valor) {
                setState(() => opacidadeMao = valor);
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
        padding: const EdgeInsets.all(12),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 10,
          children: [
            _itemLegenda(Colors.blue, 'Tônica'),
            _itemLegenda(Colors.orange, 'Notas da tríade'),
            _itemLegenda(Colors.grey, 'Outras notas'),
            _itemLegenda(
              Color.fromRGBO(255, 205, 160, opacidadeMao),
              'Mão',
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemLegenda(Color cor, String texto) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          texto,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
