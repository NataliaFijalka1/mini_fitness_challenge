import 'package:flutter/material.dart';
import '../widgets/difficulty_chip.dart';
import '../models/challenge.dart';
import 'challenge_screen.dart';

class StartScreen extends StatefulWidget {
  static const routeName = '/';

  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Difficulty _selected = Difficulty.easy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Fitness Challange'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Wähle den Schwierigkeitsgrad und starte die Herausforderung. \n '
              'Priorität liegt auf Spaß und Bewegung! Danch gibt´s Punkte & Ranglistenplatzierungen für die Session. \n'
              'Viel Erfolg!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            Text(
              'Schwierigkeitsgrad:',
              style: Theme.of(context).textTheme.titleMedium,
                           ),

            const SizedBox(height: 8),


            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: Difficulty.values.map((d) {
                
                return DifficultyChip(
                  label: d.label,
                  selected: _selected == d,
                  onTap: () => setState(() => _selected = d),
                );
              }).toList(),
            ),



            const Spacer(),
            FilledButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ChallengeScreen.routeName,
                  arguments: _selected,
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Starte Herausforderung'),
            ),
          ],
        ),
      ),
    );
  }
}