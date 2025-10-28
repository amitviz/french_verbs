import "package:flutter/material.dart";
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:french_verbs/models/verb_list.dart';
import 'package:french_verbs/models/verb_lists.dart' as model_verb_lists;

class VerbLists extends StatefulWidget {
  final String verbListsFile = "assets/verb_lists/verb_lists.json";
  const VerbLists({super.key});

  @override
  State<VerbLists> createState() => _VerbListsState();
}

class _VerbListsState extends State<VerbLists> {
  // Parsed verb lists loaded from assets
  model_verb_lists.VerbLists? verbLists;
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
    // Load verb lists JSON from assets into the `verbLists` model.
    // We call the async loader without awaiting here because initState
    // cannot be async — the loader will call setState when complete.
    loadVerbLists();
  }

  Future<void> loadVerbLists() async {
    try {
      final String jsonString = await rootBundle.loadString(
        widget.verbListsFile,
      );
      final model_verb_lists.VerbLists lists =
          model_verb_lists.VerbLists.fromJson(jsonString);
      setState(() {
        verbLists = lists;
      });
    } catch (e) {
      // If loading/parsing fails, keep verbLists as null and optionally log.
      // In production code consider reporting this to analytics or showing
      // an error state in the UI.
      // ignore: avoid_print
      print('Failed to load verb lists: $e');
    }
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

    // The list of which verbLists are selected
    final List<String> list = [
      a1Checked.toString(),
      a2Checked.toString(),
      b1Checked.toString(),
      b2Checked.toString(),
      c1Checked.toString(),
      c2Checked.toString(),
    ];

    await prefs.setStringList('verbLists', list);

    // The actual list of verbs selected
    // List<String> verbs = [];
    VerbList verbs = VerbList.fromJson("[]");

    if (a1Checked) {
      verbs.verbs.addAll(verbLists?.verbLists['a1']?.verbs ?? []);
    }
    if (a2Checked) {
      verbs.verbs.addAll(verbLists?.verbLists['a2']?.verbs ?? []);
    }
    if (b1Checked) {
      verbs.verbs.addAll(verbLists?.verbLists['b1']?.verbs ?? []);
    }
    if (b2Checked) {
      verbs.verbs.addAll(verbLists?.verbLists['b2']?.verbs ?? []);
    }
    if (c1Checked) {
      verbs.verbs.addAll(verbLists?.verbLists['c1']?.verbs ?? []);
    }
    if (c2Checked) {
      verbs.verbs.addAll(verbLists?.verbLists['c2']?.verbs ?? []);
    }

    await prefs.setStringList('selectedVerbs', verbs.toJson());
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
