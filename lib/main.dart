import 'package:flutter/material.dart';
import 'package:french_verbs/pages/dictionary_app.dart';
import 'package:french_verbs/pages/settings_app.dart';
import 'package:french_verbs/pages/verb_app.dart';
import 'package:french_verbs/themes/themes.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Le Petit Conjugueur',
      navigatorObservers: [routeObserver],
      home: VerbApp(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        '/verbes': (context) => const VerbApp(),
        '/home': (context) => const VerbApp(),
        '/dictionnaire': (context) => const DictionaryApp(),
        '/settings': (context) => const SettingsApp(),
      },
    );
  }
}
