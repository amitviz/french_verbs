import "package:flutter/material.dart";
import "package:french_verbs/pages/dictionary_widgets/dictionary_app_widget.dart";

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.chat)),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text("Dictionnaire"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.grading),
              title: Text("Test des verbes"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/verbes');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Paramètres"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(child: DictionaryAppWidget()),
    );
  }
}
