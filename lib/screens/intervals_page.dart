import 'package:flutter/material.dart';

class IntervalsPage extends StatelessWidget {
  const IntervalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const intervals = [
      '1ª — Tônica',
      '2ª menor',
      '2ª maior',
      '3ª menor',
      '3ª maior',
      '4ª justa',
      'Trítono',
      '5ª justa',
      '6ª menor',
      '6ª maior',
      '7ª menor',
      '7ª maior',
      '8ª — Oitava',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔢 Intervalos e Arpejos'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: intervals.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                intervals[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}