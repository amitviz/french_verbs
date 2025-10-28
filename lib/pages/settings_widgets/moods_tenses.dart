import 'dart:convert';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:french_verbs/models/enums.dart';

class MoodsTenses extends StatefulWidget {
  const MoodsTenses({super.key});

  @override
  State<MoodsTenses> createState() => _MoodsTensesState();
}

class _MoodsTensesState extends State<MoodsTenses> {
  Map<String, bool> moodsTenses = {};

  @override
  void initState() {
    super.initState();
    // Load saved settings (if any) when the widget initializes.
    loadSharedPrefs();
  }

  Future<void> loadSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? moodsTensesJson = prefs.getString('moodsTenses');

    if (moodsTensesJson == null || moodsTensesJson.isEmpty) {
      return; // No saved prefs — keep defaults.
    }

    setState(() {
      final Map<String, dynamic> decoded =
          json.decode(moodsTensesJson) as Map<String, dynamic>;
      moodsTenses = decoded.map((k, v) => MapEntry(k, v as bool));
    });
  }

  Future<void> setSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String moodsTensesJson = jsonEncode(moodsTenses);

    await prefs.setString('moodsTenses', moodsTensesJson);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (final m in MOOD.values) {
      for (final t in m.tenses) {
        children.add(
          CheckboxListTile(
            title: Text("${m.french} ${t.french}"),
            value: moodsTenses["${m.value}_${t.value}"] ?? false,
            onChanged: (bool? value) {
              setState(() {
                moodsTenses["${m.value}_${t.value}"] = value!;
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
