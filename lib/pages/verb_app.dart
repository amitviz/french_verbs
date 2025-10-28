import "package:flutter/material.dart";
import "package:french_verbs/pages/verb_widgets/verb_app_widget.dart";

class VerbApp extends StatelessWidget {
  const VerbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.chat)),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text("Dictionary"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dictionnaire');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: VerbAppWidget(),
    );
  }
}
