import "package:flutter/material.dart";
import "package:french_verbs/pages/dictionary_widgets/dictionary_app_widget.dart";

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dictionary")),
      body: SingleChildScrollView(child: DictionaryAppWidget()),
    );
  }
}
