import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:french_verbs/models/enums.dart';

class MoodsTenses extends StatefulWidget {
  const MoodsTenses({super.key});

  @override
  State<MoodsTenses> createState() => _MoodsTensesState();
}

class _MoodsTensesState extends State<MoodsTenses> {
  List<String> moodsTenses = [];

  @override
  void initState() {
    super.initState();
    // Load saved settings (if any) when the widget initializes.
    loadSharedPrefs();
  }

  Future<void> loadSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      moodsTenses = prefs.getStringList('moodsTenses') ?? [];
    });
  }

  Future<void> setSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('moodsTenses', moodsTenses);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (final m in MOOD.values) {
      for (final t in m.tenses) {
        children.add(
          CheckboxListTile(
            title: Text("${m.french} ${t.french}"),
            value: moodsTenses.contains("${m.value}_${t.value}") ? true : false,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  final key = "${m.value}_${t.value}";
                  if (!moodsTenses.contains(key)) {
                    moodsTenses.add(key);
                  }
                } else {
                  moodsTenses.remove("${m.value}_${t.value}");
                }
              });
              setSharedPrefs();
            },
          ),
        );
      }
      children.add(const Divider(height: 0));
    }

    return ListView(children: children);
  }
}
