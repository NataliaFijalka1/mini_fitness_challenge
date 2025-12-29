import 'package:flutter/material.dart';
import '../models/challenge.dart';
import 'ranking_screen.dart';
import 'start_screen.dart';

class ResultArgs {
  final Challenge challenge;
  final int score;

  const ResultArgs({
    required this.challenge,
    required this.score,
  });
}


class ResultScreen extends StatelessWidget {
  static const routeName = '/result';

  const ResultScreen({super.key});

String _feedbackText(int score) {
  if (score >= 80) return "Sehr gut!";
  if (score >= 40) return "Gut!";
  return "Ausbaufähig!";
}

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ResultArgs;
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Ergebnis'),
      ),



      body: Padding(
        padding: const EdgeInsets.all(16),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _feedbackText(args.score),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Challenge: ${args.challenge.title}'),
              Text('Schwierigkeit: ${args.challenge.difficulty.label}'),
              Text('Score: ${args.score} Punkte'),
              const Spacer(),

              
            FilledButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                StartScreen.routeName,
                (route) => false,
              ),
              child: const Text('Zurück zum Startbildschirm'),
            ),
          ],
         ),
       ),
    );
  }
}