import "package:flutter/material.dart";

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
    );
  }
}
