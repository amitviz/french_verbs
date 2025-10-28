import "package:flutter/material.dart";
import "package:french_verbs/pages/settings_widgets/verb_lists.dart";
import "package:french_verbs/pages/settings_widgets/moods_tenses.dart";

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.list_alt)),
              Tab(icon: Icon(Icons.edit_note)),
              Tab(icon: Icon(Icons.groups)),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            VerbLists(),
            Center(child: Text("Custom verbs")),
            MoodsTenses(),
          ],
        ),
      ),
    );
  }
}
