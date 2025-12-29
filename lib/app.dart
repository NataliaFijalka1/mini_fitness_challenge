import 'package:flutter/material.dart';
import 'screens/start_screen.dart';
import 'screens/result_screen.dart';
import 'screens/challenge_screen.dart';
import 'screens/ranking_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Fitness Challenge',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 80, 135, 164)),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: StartScreen.routeName, // erst StartScreen als Startbildschirm
      routes: {
        StartScreen.routeName: (context) => const StartScreen(),
        ChallengeScreen.routeName: (context) => const ChallengeScreen(),
        ResultScreen.routeName: (context) => const ResultScreen(),
        RankingScreen.routeName: (context) => const RankingScreen(),
      },
    );
  }
}