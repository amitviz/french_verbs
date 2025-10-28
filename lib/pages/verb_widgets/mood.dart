import "package:flutter/material.dart";

// Chip to display the mood of the verb

class MoodWidget extends StatelessWidget {
  final String mood;

  const MoodWidget({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(mood), avatar: const Icon(Icons.record_voice_over));
  }
}
