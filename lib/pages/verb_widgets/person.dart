import "package:flutter/material.dart";

// Chip to display the person of the verb
class PersonWidget extends StatelessWidget {
  final String person;

  const PersonWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: () {},
      icon: const Icon(Icons.people),
      label: Text(person),
      iconAlignment: IconAlignment.start,
    );
  }
}
