import 'package:flutter/material.dart';
import 'package:mini_fitness_challenge/screens/start_screen.dart';
import '../models/challenge.dart';
import '../services/challenge_generator.dart';
import 'result_screen.dart';
import 'dart:async';

class ChallengeScreen extends StatefulWidget {
  static const routeName = '/challenge';

  const ChallengeScreen({super.key});

@override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final _generator = ChallengeGenerator();
  Timer? _timer;

  late Difficulty _difficulty;
  late Challenge _challenge;


  bool _running = false;
  int _repsDone = 0;
  int _secondsPassed = 0;
  int _pauseCount = 0;

  @override
void didChangeDependencies() {
    super.didChangeDependencies();
      
    final args = ModalRoute.of(context)?.settings.arguments;
    _difficulty = (args is Difficulty) ? args : Difficulty.easy;

    _challenge = _generator.generate(_difficulty); //einmalig
  }

@override
void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  int get _currentValue => _challenge.kind == ChallengeKind.reps ? _repsDone : _secondsPassed;

  double get _progress => (_currentValue / _challenge.target).clamp(0,1);

  String get _goalText => _challenge.kind == ChallengeKind.reps
      ? '${_challenge.target} Wiederholungen'
      : '${_challenge.target} Sekunden';

int _calculateScore() {
    final base = _challenge.kind == ChallengeKind.reps
        ? _challenge.target 
        : (_challenge.target / 2).round();
   
final penalty = _pauseCount * 3;

final rawScore = base * _challenge.difficulty.multiplier - penalty;
return rawScore < 0 ? 0 : rawScore;

  }

void _start() {
  setState(() => _running = true);


  if (_challenge.kind == ChallengeKind.timer) {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
     if (!_running) return;

      setState(() =>
        _secondsPassed++);
        if (_secondsPassed >= _challenge.target) {
          _finish();
        }
    });
  }
}

void _pause() {
  if (!_running) return;
    setState(() {
      _running = false;
      _pauseCount++;
    });
  }

void _abbort() {
    _timer?.cancel();
    _timer = null;

    Navigator.pushNamedAndRemoveUntil(
                  context,
                  StartScreen.routeName,
                  (route) => false,);
  
  }

void _addRep() {
  if (!_running) return;
  if (_challenge.kind != ChallengeKind.reps) return;

    setState(() => _repsDone++);
      if (_repsDone >= _challenge.target) {
        _finish();
      }
    }

    void _finish() {
    _timer?.cancel();
    _timer = null;
    setState(() =>
      _running = false);

      final score = _calculateScore();

      Navigator.pushReplacementNamed(
        context, 
        ResultScreen.routeName,
        arguments: ResultArgs(
          challenge: _challenge,
          score: score,
        ),
      );
    }

    void _finishEarly() {
  _timer?.cancel();
  _timer = null;
  setState(() => _running = false);

  final ratio = (_currentValue / _challenge.target).clamp(0.0, 1.0);
  final baseScore = _calculateScore();
  final finalScore = (baseScore * ratio).round();

  Navigator.pushReplacementNamed(
    context,
    ResultScreen.routeName,
    arguments: ResultArgs(
      challenge: _challenge,
      score: finalScore,
    ),
  );
}


    void _newChallenge() {
      _timer?.cancel();
      _timer = null;

      setState(() {
      _challenge = _generator.generate(_difficulty);
      _repsDone = 0;
      _secondsPassed = 0;
      _pauseCount = 0;
      _running = false;
    });
    }

@override
  Widget build(BuildContext context) {
      final current = _currentValue;

    return Scaffold (appBar: AppBar(title: const Text ('Challenge')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: [ Text (
        'Schwierigkeitsgrad: ${_difficulty.label}',
        style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),


        Card(
          child: Padding(padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _challenge.title,
              style: Theme.of(context).textTheme.headlineSmall),
            
            const SizedBox(height: 8),
            Text('Ziel: $_goalText'),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: _progress),
            const SizedBox(height: 12),
            Center (
              child: Text('$current / ${_challenge.target}',
              style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 8),
            Text('Pausen: $_pauseCount'),
          ],
          ),
        ),
        ),

        const SizedBox(height: 12),

        if(_challenge.kind == ChallengeKind.reps)
        FilledButton.icon(
          onPressed: _running ? _addRep : null,
          icon: const Icon(Icons.add),
          label: const Text('Rep +1'),
        ),

        const Spacer(),

        Row(
          children: [
            Expanded(child:
            FilledButton(
              onPressed: _running? null : _start,
              child: const Text('Start'),
            ),
            ),
            const SizedBox(width: 8),
            Expanded(child:
            OutlinedButton(
          onPressed: _running ? _pause : null,
          child: const Text('Pause'),
         
        ),
            ),
          ],
        ),

      const SizedBox(height: 8),
      OutlinedButton.icon(
          onPressed: _currentValue > 0 ? _finishEarly : null,
          icon: const Icon(Icons.flag_outlined),
          label: const Text('Vorzeitig beenden'),
        ),
      const SizedBox(height: 8),

        Row(
     children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _newChallenge,
          icon: const Icon(Icons.shuffle),
            label: const Text('Neue Challenge'),
          ),
        ),

        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _abbort,
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Abbrechen'),
          ),
        ),
     ],
    ),


        ],
      ),
    ),
    );
    
  }

  }