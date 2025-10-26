import "package:flutter/material.dart";

class DefinitionWidget extends StatelessWidget {
  final String definition;
  final bool isRevealed;
  final VoidCallback onTap;

  const DefinitionWidget({
    super.key,
    required this.definition,
    required this.isRevealed,
    required this.onTap,
  });

  void _handleTap() {
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _handleTap,
      // icon: Icon(isRevealed ? Icons.subtitles : Icons.subtitles_outlined),
      icon: Icon(isRevealed ? Icons.menu_book : null),
      label: Text(isRevealed ? definition : ""),
      iconAlignment: IconAlignment.start,
    );
  }
}
