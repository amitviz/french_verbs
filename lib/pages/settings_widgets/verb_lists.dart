import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class VerbLists extends StatefulWidget {
  const VerbLists({super.key});

  @override
  State<VerbLists> createState() => _VerbListsState();
}

class _VerbListsState extends State<VerbLists> {
  bool a1Checked = false;
  bool a2Checked = false;
  bool b1Checked = false;
  bool b2Checked = false;
  bool c1Checked = false;
  bool c2Checked = false;

  @override
  void initState() {
    super.initState();
    // Load saved checkbox values (if any) when the widget initializes.
    loadSharedPrefs();
  }

  Future<void> loadSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? list = prefs.getStringList('verbLists');

    if (list == null || list.isEmpty) return; // No saved prefs — keep defaults.

    setState(() {
      if (list.length > 0) a1Checked = list[0] == 'true';
      if (list.length > 1) a2Checked = list[1] == 'true';
      if (list.length > 2) b1Checked = list[2] == 'true';
      if (list.length > 3) b2Checked = list[3] == 'true';
      if (list.length > 4) c1Checked = list[4] == 'true';
      if (list.length > 5) c2Checked = list[5] == 'true';
    });
  }

  Future<void> setSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> list = [
      a1Checked.toString(),
      a2Checked.toString(),
      b1Checked.toString(),
      b2Checked.toString(),
      c1Checked.toString(),
      c2Checked.toString(),
    ];

    await prefs.setStringList('verbLists', list);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CheckboxListTile(
          value: a1Checked,
          onChanged: (bool? value) {
            setState(() {
              a1Checked = value!;
            });
            setSharedPrefs();
          },
          title: const Text('A1'),
          subtitle: const Text(
            'acheter, aimer, aller, apprendre, assurer, augmenter, avoir, changer, choisir, comprendre, compter, connaître, créer, découvrir, ...',
          ),
        ),
        // const Divider(height: 0),
        CheckboxListTile(
          value: a2Checked,
          onChanged: (bool? value) {
            setState(() {
              a2Checked = value!;
            });
            setSharedPrefs();
          },
          title: const Text('A2'),
          subtitle: const Text(
            'ajouter, améliorer, apporter, arriver, attendre, baisser, bénéficier, chercher, commencer, conseiller, conserver, considérer, ...',
          ),
        ),
        // const Divider(height: 0),
        CheckboxListTile(
          value: b1Checked,
          onChanged: (bool? value) {
            setState(() {
              b1Checked = value!;
            });
            setSharedPrefs();
          },
          title: const Text('B1'),
          subtitle: const Text(
            "accepter, accueillir, acquérir, atteindre, attirer, céder, communiquer, comparer, concerner, consacrer, consulter, décider, défendre, ...",
          ),
        ),
        // const Divider(height: 0),
        CheckboxListTile(
          value: b2Checked,
          onChanged: (bool? value) {
            setState(() {
              b2Checked = value!;
            });
            setSharedPrefs();
          },
          title: const Text('B2'),
          subtitle: const Text(
            "accorder, adapter, adopter, afficher, affirmer, agir, appliquer, calculer, citer, compenser, concentrer, concevoir, confier, confirmer, ...",
          ),
        ),
        // const Divider(height: 0),
        CheckboxListTile(
          value: c1Checked,
          onChanged: (bool? value) {
            setState(() {
              c1Checked = value!;
            });
            setSharedPrefs();
          },
          title: const Text('C1'),
          subtitle: const Text(
            "abandonner, accéder, affronter, analyser, apprécier, assister, assumer, attribuer, avancer, bouger, cacher, casser, charger, chuter, ...",
          ),
        ),
        // const Divider(height: 0),
        CheckboxListTile(
          value: c2Checked,
          onChanged: (bool? value) {
            setState(() {
              c2Checked = value!;
            });
            setSharedPrefs();
          },
          title: const Text('C2'),
          subtitle: const Text(
            "aborder, aboutir, accélérer, accompagner, accomplir, accumuler, adresser, alimenter, amener, annoncer, anticiper, appartenir, ...",
          ),
        ),
        // const Divider(height: 0),
      ],
    );
  }
}
