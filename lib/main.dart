import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'state/session_results_store.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SessionResultsStore(),
      child: const App(),
    ),
  );
}

