enum Difficulty { easy, medium, hard }
extension DifficultyExtension on Difficulty {
  String get label {
    switch (this) {
      case Difficulty.easy:
        return 'Einfach';
      case Difficulty.medium:
        return 'Mittel';
      case Difficulty.hard:
        return 'Schwer';
    }
  }
}

//erweitere es dann später 