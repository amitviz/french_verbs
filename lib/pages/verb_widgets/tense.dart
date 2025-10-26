import "package:flutter/material.dart";

// Chip to display the tense of the verb

class TenseWidget extends StatelessWidget {
  final String tense;

  final Map<String, String> tenses = {
    "infinitive-present": "présent",
    "present": "présent",
    "imperfect": "imparfait",
    "future": "futur",
    "simple-past": "passé simple",
    "imperative-present": "présent",
    "present-participle": "gérondif",
    "past-participle": "passé",
  };

  TenseWidget({super.key, required this.tense});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: () {},
      icon: const Icon(Icons.access_time_filled),
      label: Text(tenses[tense] ?? "Error: $tense"),
      iconAlignment: IconAlignment.start,
    );
  }
}
