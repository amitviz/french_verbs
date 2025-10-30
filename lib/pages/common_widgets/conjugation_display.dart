import 'package:flutter/material.dart';
import 'package:french_verbs/models/enums.dart';
import "package:french_verbs/pages/common_widgets/conjugation_table.dart";

class ConjugationDisplay extends StatelessWidget {
  final Map<FORM, List<String>?>? conjugatedTense;
  final MOOD mood;
  final String title;
  final bool isRevealed;
  final bool isExpanded;

  const ConjugationDisplay({
    super.key,
    required this.conjugatedTense,
    this.mood = MOOD.indicative,
    this.title = "Conjugation",
    this.isRevealed = false,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    ConjugationTable conjugationTable = ConjugationTable(
      conjugatedTense: conjugatedTense,
      mood: mood,
    );

    return Visibility(
      visible: isRevealed,
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        title: Text(title),
        children: <Widget>[conjugationTable],
      ),
    );
  }
}
