import 'package:flutter/material.dart';
import 'package:french_verbs/models/enums.dart';
import 'package:french_verbs/utilities/utilities.dart';

class ConjugationDisplay extends StatelessWidget {
  final Map<FORM, List<String>?>? conjugatedTense;

  final String title;
  final bool isRevealed;
  final bool isExpanded;

  const ConjugationDisplay({
    super.key,
    required this.conjugatedTense,
    this.title = "Conjugation",
    this.isRevealed = false,
    this.isExpanded = false,
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
                    style: TextStyle(fontWeight: FontWeight.bold),
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
      columns: const <DataColumn>[
        DataColumn(label: Text('')),
        DataColumn(label: Text('')),
      ],
      rows: rows,
    );

    return Visibility(
      visible: isRevealed,
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        title: Text(title),
        subtitle: Text(''),
        children: <Widget>[conjugationTable],
      ),
    );
  }
}
