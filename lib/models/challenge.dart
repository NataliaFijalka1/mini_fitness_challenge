enum Difficulty { easy, medium, hard }
enum ChallengeKind { reps, timer }

class Challenge {
  final String title;        // z.B. "Kniebeugen"
  final ChallengeKind kind;  // reps oder timer
  final int target;          // Wiederholungen oder Sekunden
  final Difficulty difficulty;

  const Challenge({
    required this.title,
    required this.kind,
    required this.target,
    required this.difficulty,
  });
}

extension DifficultyX on Difficulty {
  String get label => switch (this) {
        Difficulty.easy => "Leicht", // geändert, so ist übersichtilicher 
        Difficulty.medium => "Mittel",
        Difficulty.hard => "Schwer",
      };

  int get multiplier => switch (this) {
        Difficulty.easy => 1,
        Difficulty.medium => 2,
        Difficulty.hard => 3,
      };
}

extension ChallengeKindX on ChallengeKind {
  String get label => switch (this) {
        ChallengeKind.reps => "Wiederholungen",
        ChallengeKind.timer => "Zeit",
      };
}
// Modell einer Fitness-Challenge (sessionbasiert, ohne Speicherung)