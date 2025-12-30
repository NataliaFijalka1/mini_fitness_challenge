import 'dart:math';
import '../models/challenge.dart';


class ChallengeGenerator {
  final Random _rnd = Random();

  Challenge generate(Difficulty difficulty) {
    final pool = _exercisePool(difficulty);
    final title = pool[_rnd.nextInt(pool.length)];

    // 50/50: reps oder timer
    final kind = _rnd.nextBool() ? ChallengeKind.reps : ChallengeKind.timer;

    final target = switch (difficulty) {
      Difficulty.easy => kind == ChallengeKind.reps ? _between(8, 15) : _between(20, 40),
      Difficulty.medium => kind == ChallengeKind.reps ? _between(15, 30) : _between(40, 70),
      Difficulty.hard => kind == ChallengeKind.reps ? _between(30, 60) : _between(70, 120),
    };

    return Challenge(
      title: title,
      kind: kind,
      target: target,
      difficulty: difficulty,
    );
  }

  int _between(int min, int maxInclusive) => min + _rnd.nextInt(maxInclusive - min + 1);

  List<String> _exercisePool(Difficulty d) => switch (d) {
        Difficulty.easy => ["Kniebeugen", "Wand-Sitz", "Hampelmänner", "Armkreisen"],
        Difficulty.medium => ["Liegestütze", "Ausfallschritte", "Mountain Climbers", "Plank"],
        Difficulty.hard => ["Burpees", "Jump Squats", "High Knees", "Plank Shoulder Taps"],
      };
}
