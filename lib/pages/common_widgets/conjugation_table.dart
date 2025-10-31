import 'package:flutter/material.dart';
import "package:french_verbs/models/enums.dart";
import "package:french_verbs/utilities/utilities.dart";

class ConjugationTable extends StatelessWidget {
  final Map<FORM, List<String>?>? conjugatedTense;
  final MOOD mood;
  final String? title;

  const ConjugationTable({
    super.key,
    required this.conjugatedTense,
    this.mood = MOOD.indicative,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Build rows from the map
    List<DataRow> rows = [];

    if (conjugatedTense != null) {
      conjugatedTense!.forEach((form, list) {
        String label = form.french;

        if (form == FORM.je && startsWithVowel(list?.first ?? '')) {
          label = "j'";
        }
        if (mood == MOOD.subjunctive) {
          if (startsWithVowel(label)) {
            label = "qu'$label";
          } else {
            label = "que $label";
          }
        }

        if (list == null || list.isEmpty) {
          // This shouldn't happen
          rows.add(
            DataRow(cells: [DataCell(Text(label)), DataCell(Text('-'))]),
          );
        } else {
          // If list has multiple entries, show them joined
          rows.add(
            DataRow(
              cells: [
                DataCell(
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      label,
                      style: TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    list.join(', '),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      });
    }

    DataTable conjugationTable = DataTable(
      headingRowHeight: 0,
      dividerThickness: 0,
      columnSpacing: 6,
      horizontalMargin: 4,
      columns: <DataColumn>[
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
      ],
      rows: rows,
    );

    return Column(
      children: [
        Text(
          title?.toUpperCase() ?? "",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.start,
        ),
        conjugationTable,
      ],
    );
  }
}
