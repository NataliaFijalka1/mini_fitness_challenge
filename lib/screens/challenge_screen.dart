import 'package:flutter/material.dart';
import '../models/challenge.dart';

class ChallengeScreen extends StatelessWidget {
  static const routeName = '/challenge';

  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final difficulty = ModalRoute.of(context)!.settings.arguments as Difficulty;
     

     return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge '),
      ),
      body: Center(
        child: Text(
          'Gewählter Schwierigkeitsgrad: ${difficulty.label}\n(Challange-Logik kommt als Nächstes...)',
          
        ),
      ),
     );
  }
}