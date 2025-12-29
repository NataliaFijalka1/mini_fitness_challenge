import 'package:flutter/material.dart';
import 'package:mini_fitness_challenge/models/challenge.dart';
import 'start_screen.dart';

class RankingArgs {
  final String name;
  final int score;
  final String challengeTitle;
  final Difficulty difficulty;

  const RankingArgs({
    required this.name,
    required this.score,
    required this.challengeTitle,
    required this.difficulty,
  
  });
}




class RankingScreen extends StatelessWidget {
  static const routeName = '/ranking';

  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
final args = ModalRoute.of(context)?.settings.arguments as RankingArgs?;

    return Scaffold(
      appBar: AppBar(title: const Text('Ranking (Session)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: args == null
        ? const Center(child: Text('Noch keine Ergebnisse'))
        : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Top Ergebnis (Platzhalter)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: Text(args.name),
                subtitle: Text('${args.challengeTitle} - ${args.difficulty.label}'),
                trailing: Text(args.score.toString(),
                style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            ),
            const Spacer(),
            FilledButton(onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                StartScreen.routeName,
                (route) => false,
              );
            },
            child: const Text('Neue Session starten'),
            ),
          ],
        )
       
      ),
    );
  }
}