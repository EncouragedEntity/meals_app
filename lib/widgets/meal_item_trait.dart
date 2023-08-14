import 'package:flutter/material.dart';

class MealTrait extends StatelessWidget {
  const MealTrait({super.key, required this.icon, required this.text});

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(
          width: 2,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
