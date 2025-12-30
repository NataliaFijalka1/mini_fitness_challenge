import 'package:flutter/material.dart';
import '../widgets/difficulty_chip.dart';
import '../models/challenge.dart';
import 'challenge_screen.dart';
import '../widgets/info_pill.dart';


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
        title: const Text('Mini Fitness Challenge'),
      ),
      body: SafeArea(
        child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', 
                    width: 120, height: 120),
                    const SizedBox(width: 12),
                    Expanded(child: 
             Text(
              'Willkommen zur Mini Fitness Challenge!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
                    ),
                  ],
                ),
            const SizedBox(height: 8),
            Text(
              'Wähle den Schwierigkeitsgrad und starte die Herausforderung mit einer zufälligen Challenge.\n'
              'Priorität liegt auf Spaß und Bewegung! Danach gibt es Punkte & Ranglistenplatzierungen für die Session.\n'
              'Viel Erfolg!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: const [
                InfoPill(icon: Icons.timer_outlined, text: 'Timer & Reps'),
                InfoPill(icon: Icons.leaderboard_outlined, text: 'Ranking'),
                InfoPill(icon: Icons.lock_outline, text: 'Keine Speicherung'),
              ],
            ),
              ],
            ),
            ),

            const SizedBox(height: 16),

            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(padding: 
              const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Text(
              'Schwierigkeitsgrad:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,),
            ),

            const SizedBox(height: 12),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: Difficulty.values.map((d) {
                
                return DifficultyChip(
                  label: d.label,
                  selected: _selected == d,
                  onTap: () => setState(() => _selected = d),
                );
              }).toList(),
            ),
                ],
              ),
              ),
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
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),

            Text('Tipp: Starte leicht und steigere dich!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
            ),
            
          ], 
        ),  

        ),
      ),
    );  
  }
}