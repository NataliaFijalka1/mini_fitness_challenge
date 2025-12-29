import 'challenge.dart';

class SessionResult {
  final String name;
  final int score;
  final String challengeTitle;
  final Difficulty difficulty;
  final DateTime createdAt;

  SessionResult({
    required this.name,
    required this.score,
    required this.challengeTitle,
    required this.difficulty,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
