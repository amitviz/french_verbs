import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;

/// Simple helper to load JSON dictionaries from assets.
///
/// Currently provides loading for `assets/dictionaries/verbs.json` and
/// caches the parsed Map so subsequent calls are fast.
class Dictionary {
  /// The verbs dictionary loaded from `assets/dictionaries/verbs.json`.
  final Map<String, dynamic> verbs;
  final Map<String, dynamic> conjugationRules;

  final Map<String, List<String>> moods = {
    "infinitive": ["infinitive-present"],
    "indicative": ["present", "imperfect", "future", "simple-past"],
    "conditional": ["present"],
    "subjunctive": ["present", "imperfect"],
    "imperative": ["imperative-present"],
    "participle": ["present-participle", "past-participle"],
  };

  final Map<String, List<String>> tenses = {
    "infinitive-present": ["none"],
    "present": ["je", "tu", "il", "elle", "on", "nous", "vous", "ils", "elles"],
    "imperfect": [
      "je",
      "tu",
      "il",
      "elle",
      "on",
      "nous",
      "vous",
      "ils",
      "elles",
    ],
    "future": ["je", "tu", "il", "elle", "on", "nous", "vous", "ils", "elles"],
    "simple-past": [
      "je",
      "tu",
      "il",
      "elle",
      "on",
      "nous",
      "vous",
      "ils",
      "elles",
    ],
    "imperative-present": ["(tu)", "(nous)", "(vous)"],
    "present-participle": ["(gérondif)"],
    "past-participle": ["(m.)", "(f.)", "(m.pl.)", "(f.pl.)"],
  };

  final Map<String, int> persons = {
    "none": 0,
    "je": 0,
    "tu": 1,
    "il": 2,
    "elle": 2,
    "on": 2,
    "nous": 3,
    "vous": 4,
    "ils": 5,
    "elles": 5,
    "(tu)": 0,
    "(nous)": 1,
    "(vous)": 2,
    "(gérondif)": 0,
    "(m.)": 0,
    "(f.)": 1,
    "(m.pl.)": 2,
    "(f.pl.)": 3,
  };

  Dictionary(this.verbs, this.conjugationRules);

  static const String _verbsAsset = 'assets/dictionaries/verbs.json';
  static const String _conjugationAsset =
      'assets/dictionaries/conjugations.json';

  // Internal cache to avoid repeatedly reading/parsing the asset.
  static Map<String, dynamic>? _verbsCache;
  static Map<String, dynamic>? _conjugationCache;

  // Global Random used when a caller doesn't provide one. Exposed as static
  // so tests can inject a seeded Random if deterministic behavior is needed.
  static final Random _globalRandom = Random();

  /// Async factory that returns a `Dictionary` instance whose [verbs]
  /// property contains the parsed JSON from the verbs asset.
  ///
  /// Uses an in-memory cache by default to avoid reloading the asset. Set
  /// [forceReload] to true to re-read the asset and update the cache.
  static Future<Dictionary> load({bool forceReload = false}) async {
    if (_verbsCache == null || forceReload) {
      final jsonString = await rootBundle.loadString(_verbsAsset);
      final parsed = jsonDecode(jsonString);

      if (parsed is Map<String, dynamic>) {
        _verbsCache = parsed;
      } else {
        throw FormatException(
          'Expected a JSON object at top level in $_verbsAsset',
        );
      }
    }

    if (_conjugationCache == null || forceReload) {
      final jsonString = await rootBundle.loadString(_conjugationAsset);
      final parsed = jsonDecode(jsonString);

      if (parsed is Map<String, dynamic>) {
        _conjugationCache = parsed;
      } else {
        throw FormatException(
          'Expected a JSON object at top level in $_conjugationAsset',
        );
      }
    }

    return Dictionary(
      Map<String, dynamic>.from(_verbsCache!),
      Map<String, dynamic>.from(_conjugationCache!),
    );
  }

  /// Returns a randomly selected verb entry from the loaded verbs map.
  ///
  /// The returned value is a [MapEntry] where the `key` is the verb's
  /// top-level identifier (likely the infinitive) and `value` is the
  /// associated JSON object. An optional [random] can be provided for
  /// deterministic selection in tests.
  MapEntry<String, dynamic> randomVerb([Random? random]) {
    if (verbs.isEmpty) {
      throw StateError('No verbs available in this Dictionary instance.');
    }

    final r = random ?? _globalRandom;
    final keys = verbs.keys.toList(growable: false);
    final selectedKey = keys[r.nextInt(keys.length)];
    return MapEntry(selectedKey, verbs[selectedKey]);
  }

  /// Returns the cached verbs map if already loaded, otherwise null.
  ///
  /// Note: this returns the cached instance (not the instance field), so
  /// callers should prefer creating a `Dictionary` via [load] which will
  /// copy the cached map into the instance.
  static Map<String, dynamic>? get cachedVerbs => _verbsCache;
  static Map<String, dynamic>? get cachedConjugationRules => _conjugationCache;
}
