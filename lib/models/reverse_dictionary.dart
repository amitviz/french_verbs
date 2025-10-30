import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import "term.dart";

class ReverseDictionary {
  // cached future so load() only does the IO/parsing once
  static Future<ReverseDictionary>? _cachedLoad;

  final String rDictionaryFile = "assets/dictionaries/reverse_dictionary.json";
  late Map<String, Term> terms;

  Map<String, Term> _parseTerms(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      return decoded.map((k, v) => MapEntry(k, Term.fromJson(v)));
    }

    if (decoded is List) {
      final map = <String, Term>{};
      return map;
    }

    throw FormatException(
      'Unexpected JSON structure for reverse_dictionary.json: ${decoded.runtimeType}',
    );
  }

  static Future<ReverseDictionary> load() {
    return _cachedLoad ??= _loadFromAssets();
  }

  // private constructor
  ReverseDictionary._();

  static Future<ReverseDictionary> _loadFromAssets() async {
    final rDict = ReverseDictionary._();

    final rDictJsonString = await rootBundle.loadString(rDict.rDictionaryFile);
    final rDictJson = jsonDecode(rDictJsonString);
    rDict.terms = rDict._parseTerms(rDictJson);

    return rDict;
  }
}
