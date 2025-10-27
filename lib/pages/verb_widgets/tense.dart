import "package:flutter/material.dart";

// Chip to display the tense of the verb

class TenseWidget extends StatelessWidget {
  final String tense;

  const TenseWidget({super.key, required this.tense});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: () {},
      icon: const Icon(Icons.access_time_filled),
      label: Text(tense),
      iconAlignment: IconAlignment.start,
    );
  }
}
