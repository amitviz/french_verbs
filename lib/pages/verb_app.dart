import "package:flutter/material.dart";
import "package:french_verbs/pages/verb_widgets/verb_app_widget.dart";

class VerbApp extends StatelessWidget {
  const VerbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: SingleChildScrollView(child: VerbAppWidget()),
    );
  }
}
