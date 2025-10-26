import 'package:flutter/widgets.dart';

import 'dictionary.dart';

/// Small example utility showing how to load the verbs dictionary.
///
/// Call `runExample()` from a debug entrypoint or a small test to verify
/// the asset is parsed correctly. Note: `WidgetsFlutterBinding.ensureInitialized()`
/// is used to make sure the asset bundle is available when running outside
/// of a full Flutter app lifecycle.
Future<void> runExample() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Use the instance-based API: create a Dictionary instance containing the
  // verbs map.
  final dictionary = await Dictionary.load();
  final verbs = dictionary.verbs;

  print('Loaded verbs: ${verbs.length} top-level keys');

  if (verbs.isNotEmpty) {
    final firstKey = verbs.keys.first;
    print('First key: $firstKey => ${verbs[firstKey]}');
  }
}
