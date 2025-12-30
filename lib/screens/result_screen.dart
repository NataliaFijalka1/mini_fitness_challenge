import 'package:flutter/material.dart';
import '../models/challenge.dart';
import 'ranking_screen.dart';
import 'start_screen.dart';
import 'challenge_screen.dart';
import 'package:provider/provider.dart';
import '../state/session_results_store.dart';
import '/models/session_result.dart';

class ResultArgs {
  final Challenge challenge;
  final int score;

  const ResultArgs({
    required this.challenge,
    required this.score,
  });
}


class ResultScreen extends StatefulWidget {
  static const routeName = '/result';
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _nameController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }


int _maxScoreFor(Challenge c) {
  final base = c.kind == ChallengeKind.reps ? c.target : (c.target / 2).round();
  return base * c.difficulty.multiplier;
}
int _scorePercent(ResultArgs args) {
  final maxScore = _maxScoreFor(args.challenge);
  if (maxScore <= 0) return 0;
  final double ratio =
    (args.score.toDouble() / maxScore).clamp(0.0, 1.0).toDouble();
  
  return (ratio * 100).round();
}

String _feedbackTextPercent(ResultArgs args) {
  final percent = _scorePercent(args);
  if (percent >= 80) return "Sehr gut!";
  if (percent >= 40) return "Gut!";
  return "Ausbaufähig!";
}

void _openRanking(ResultArgs args) {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() =>
        _errorText = 'Bitte gib deinen Namen ein.');
      return;
    }

    setState(() => _errorText = null);

     final result = SessionResult(
      name: name,
      score: args.score,
      challengeTitle: args.challenge.title,
      difficulty: args.challenge.difficulty,
    );

    context.read<SessionResultsStore>().addResult(result);
    Navigator.pushReplacementNamed(context, RankingScreen.routeName);
   
    
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ResultArgs;

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Ergebnis')),
         body: Padding(
        padding: const EdgeInsets.all(16),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _feedbackTextPercent(args),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),

            Text('Challenge: ${args.challenge.title}'),
              Text('Schwierigkeit: ${args.challenge.difficulty.label}'),
              const SizedBox(height: 8),
              Text('Score: ${args.score} Punkte', 
              style: Theme.of(context).textTheme.titleLarge,
              ),
              
            const SizedBox(height: 16),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Dein Name für das Ranking',
                hintText: 'z.B. Max Mustermann',
                errorText: _errorText,
                border: const OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
            onChanged: (_) {
              if (_errorText != null) setState(() => _errorText = null);
            },
            ),  

              const Spacer(),

            FilledButton.icon(onPressed: () => _openRanking(args), 
            icon: const Icon(Icons.leaderboard),
            label: const Text('Zum Ranking hinzufügen'),
            ),
            const SizedBox(height: 8),

            OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                ChallengeScreen.routeName,
                (route) => false,
                arguments: args.challenge.difficulty,
              );
            },
            icon: const Icon(Icons.replay),
            label: const Text('Nochmalige Challenge mit gleicher Schwierigkeit'),
            ),
            const SizedBox(height: 8),
    
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  StartScreen.routeName,
                  (route) => false,
                );
              },
              child: const Text('Zurück zum Startbildschirm'),
            ),
          ],
         ),
       ),
    );
  }
}