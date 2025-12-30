import 'package:flutter/material.dart';
import 'package:mini_fitness_challenge/models/challenge.dart';
import 'package:mini_fitness_challenge/screens/challenge_screen.dart';
import 'package:mini_fitness_challenge/state/session_results_store.dart';
import 'package:provider/provider.dart';
import 'start_screen.dart';


class RankingScreen extends StatelessWidget {
  static const routeName = '/ranking';

  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
final store = context.watch<SessionResultsStore>();
final results = store.sortedResults;

    return Scaffold(
      appBar: AppBar(title: const Text('Ranking (Session)'),
      actions: [
        IconButton(
          tooltip: 'Session zurücksetzen',
          onPressed: results.isEmpty ? null : store.clear,
          icon: const Icon(Icons.delete_outline),
        )
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: results.isEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Noch keine Ergebnisse vorhanden in dieser Session.'),            
            
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
       : Column( 
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Ergebnisse dieser Session:',
            style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                itemCount: results.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final r = results[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}')),
                    title: Text(r.name),
                    subtitle: Text(
                      '${r.challengeTitle} - ${r.difficulty.label}'),
                    trailing: Text(
                    r.score.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      final top = results.first;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        ChallengeScreen.routeName,
                        (route) => false,
                        arguments: top.difficulty,
                      );
                    },
                    icon: const Icon(Icons.replay),
                    label: const Text('Replay Bestleistungsschwierigkeitsgrad'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      StartScreen.routeName,
                      (route) => false,
                    );
                  },
                  child: const Text('Startbildschirm'),
                  ),

                ),
              ],
            ),
          ],
       )
      ),
    );
  }
}