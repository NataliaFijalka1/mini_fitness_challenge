import 'package:flutter/material.dart';
import '../models/challenge.dart';
import '../sevices/challange_generator.dart';
import 'result_screen.dart';

class ChallengeScreen extends StatefulWidget {
  static const routeName = '/challenge';

  const ChallengeScreen({super.key});

@override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}
class _ChallengeScreenState extends State<ChallengeScreen> {
  final _generator = ChallengeGenerator();

  late Difficulty _difficulty;
  late Challenge _challenge;

  @override
void didChangeDependencies() {
    super.didChangeDependencies();
      
    final args = ModalRoute.of(context)?.settings.arguments;
    _difficulty = (args is Difficulty) ? args : Difficulty.easy;

    _challenge = _generator.generate(_difficulty); //einmalig
  }



int _calculateScore(Challenge c) {
    final base = c.kind == ChallengeKind.reps ? c.target : (c.target / 2).round();
    return base * c.difficulty.multiplier;
    // daweil:
    // reps: target * multiplier
    // timer: (target/2) * multiplier (weil Sekunden tendenziell größer sind)
  }

  String _goalText(Challenge c) {
    return c.kind == ChallengeKind.reps
        ? '${c.target} Wiederholungen'
        : '${c.target} Sekunden';
  } 



@override
  Widget build(BuildContext context) {
    final score = _calculateScore(_challenge);

    return Scaffold (appBar: AppBar(title: const Text ('Challange'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [ Text (
        'Schwierigkeitsgrad: ${_difficulty.label}',
        style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),


        Card(
          child: Padding(padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _challenge.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Type: ${_challenge.kind.label}'),
            const SizedBox(height: 4),
            Text('Ziel: ${_goalText(_challenge)}'),
            const SizedBox(height: 12),
            Text('Punkte: $score'),
            
          ],),
        ),
        ),

        const Spacer(),

        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              _challenge = _generator.generate(_difficulty);
            });
          },
          icon: const Icon(Icons.shuffle),
          label: const Text('Neue Challenge generieren'),
        ),
        const SizedBox(height: 8),



        FilledButton.icon(onPressed: () {
          Navigator.pushNamed(
            context,
            ResultScreen.routeName,
            arguments: ResultArgs(
              challenge: _challenge,
              score: score,
            ),
            );
          
        },
        icon: const Icon(Icons.check),
        label: const Text('Challenge abgeschlossen'),
        ),
      ],
      ),
    ),
    );
    
  }

  }