//das für die Schwierigkeitsgrad-Auswahl verwendete Widget

import 'package:flutter/material.dart';

class DifficultyChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const DifficultyChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return ChoiceChip(label: Text(label), selected: selected, onSelected: (_) => onTap(),
    );
  }
}