import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  static const routeName = '/ranking';

  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: Center(
        child: Text(
          'Rankingbildschirm',
        ),
      ),
    );
  }
}