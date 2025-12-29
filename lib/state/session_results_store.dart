import 'package:flutter/foundation.dart';
import '../models/session_result.dart';

class SessionResultsStore extends ChangeNotifier {
  final List<SessionResult> _results = [];

  List<SessionResult> get results => List.unmodifiable(_results);

  void addResult(SessionResult result) {
    _results.add(result);
    notifyListeners();
  }

  void clear() {
    _results.clear();
    notifyListeners();
  }

  // Hilfsfunktion: Ranking sortiert (höchster Score zuerst)
  List<SessionResult> get sortedResults {
    final copy = List<SessionResult>.from(_results);
    copy.sort((a, b) {
      final byScore = b.score.compareTo(a.score);
      if (byScore != 0) return byScore;
      return a.createdAt.compareTo(b.createdAt); // bei Gleichstand: älter zuerst
    });
    return copy;
  }
}
