import 'package:flutter/material.dart';

class EarTrainingPage extends StatelessWidget {
  const EarTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👂 Treino de Ouvido'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hearing,
                size: 90,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                'Desafio de percepção',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Ouça uma nota e tente descobrir qual é.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: const Text('COMEÇAR DESAFIO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}