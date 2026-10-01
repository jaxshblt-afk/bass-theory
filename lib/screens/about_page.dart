import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ℹ️ Sobre o aplicativo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.music_note,
                size: 80,
                color: Colors.blueAccent,
              ),

              SizedBox(height: 20),

              Text(
                'BASS THEORY',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                'Versão 3.0.0',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Teoria musical desenvolvida para contrabaixistas.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 20),

              Text(
                'Tonalidades • Graus • Escalas • Modos • '
                'Intervalos • Arpejos • Afinador • '
                'Descoberta de tom pela voz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              SizedBox(height: 30),

              Text(
                'Desenvolvedor',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),

              SizedBox(height: 5),

              Text(
                'DC Music',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Créditos',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),

              SizedBox(height: 5),

              Text(
                'Darlon Cunha',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}