import "package:flutter/material.dart";

// Chip to display the mood of the verb

class MoodWidget extends StatelessWidget {
  final String mood;

  final Map<String, String> moods = {
    "infinitive": "infinitif",
    "indicative": "indicatif",
    "conditional": "conditionnel",
    "subjunctive": "subjonctif",
    "imperative": "impératif",
    "participle": "participe",
  };

  MoodWidget({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: () {},
      icon: const Icon(Icons.record_voice_over),
      label: Text(moods[mood] ?? "Error: $mood"),
      iconAlignment: IconAlignment.start,
    );
  }
}
