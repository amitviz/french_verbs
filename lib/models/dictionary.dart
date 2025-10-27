import "dart:convert";
import "dart:math";
import 'package:flutter/services.dart' show rootBundle;
import "verb.dart";
import "conjugation.dart";
import "enums.dart";

class Dictionary {
  final String verbsFile = "assets/dictionaries/verbs.json";
  final String conjugationsFile = "assets/dictionaries/conjugations.json";
  late Map<String, Verb> verbs;
  late Map<String, Conjugation> conjugations;

  Map<String, Verb> _parseVerbs(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      return decoded.map(
        (k, v) => MapEntry(k, Verb.fromJson(v as Map<String, dynamic>)),
      );
    }

    if (decoded is List) {
      final map = <String, Verb>{};
      for (final item in decoded) {
        if (item is Map<String, dynamic>) {
          final verb = Verb.fromJson(item);
          // use the verb.type as the key when input is a list
          map[verb.type] = verb;
        }
      }
      return map;
    }

    throw FormatException(
      'Unexpected JSON structure for verbs.json: ${decoded.runtimeType}',
    );
  }

  Map<String, Conjugation> _parseConjugations(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      return decoded.map(
        (k, v) => MapEntry(k, Conjugation.fromJson(v as Map<String, dynamic>)),
      );
    }
    if (decoded is List) {
      final map = <String, Conjugation>{};
      for (final item in decoded) {
        if (item is Map<String, dynamic>) {
          // If the item is a single-entry map like {"verb": { ... }}, use that key.
          if (item.length == 1) {
            final key = item.keys.first;
            final value = item.values.first as Map<String, dynamic>;
            map[key] = Conjugation.fromJson(value);
            continue;
          }

          // If the item contains an explicit identifier field, use it as the key.
          if (item.containsKey('type')) {
            map[item['type'] as String] = Conjugation.fromJson(item);
            continue;
          }

          // Unable to determine a key for this list item; skip it.
        }
      }
      return map;
    }

    throw FormatException(
      'Unexpected JSON structure for conjugations.json: ${decoded.runtimeType}',
    );
  }

  List<String>? _getConjugation(
    String verb,
    MOOD mood,
    TENSE tense,
    FORM form,
  ) {
    String verbEnding = verbs[verb]?.type.split(":").last ?? "";
    String verbRoot = verb.substring(0, verb.length - verbEnding.length);
    List<String>? variants = conjugations[verbs[verb]?.type]
        ?.moods[mood.value]
        ?.tenses[tense.value]
        ?.forms[form.value]
        .variants;

    // Return null when there are no variants (null or empty list)
    if (variants == null || variants.isEmpty) return null;

    List<String> conjugatedVariants = List.from(
      variants,
    ).map((v) => "${verbRoot}${v}").toList();

    // print("${verb}: ${verbs[verb]}");
    // print("verbtype: ${verbs[verb]?.type}");
    // print("verb infinitive ending: $verbEnding");
    // print("verb root: $verbRoot");
    // print("definitions: ${verbs[verb]?.definitions.join('; ')}");
    // print("conjugated endings: ${variants}");

    return conjugatedVariants;
  }

  Map<FORM, List<String>?>? getConjugation(
    String verb,
    MOOD mood,
    TENSE tense,
    FORM form,
  ) {
    List<String>? c = _getConjugation(verb, mood, tense, form);

    if (c != null) {
      return {form: c};
    } else {
      return null;
    }
  }

  Map<FORM, List<String>?>? conjugateTense(
    String verb,
    MOOD mood,
    TENSE tense, [
    bool allForms = false,
  ]) {
    Map<FORM, List<String>?> conjugatedForms = {};

    for (FORM form in allForms ? tense.forms : tense.conjugationForms) {
      List<String>? c = _getConjugation(verb, mood, tense, form);
      if (c != null) {
        conjugatedForms[form] = c;
      }
    }

    if (conjugatedForms.isEmpty) {
      return null;
    } else {
      return conjugatedForms;
    }
  }

  Map<TENSE, Map<FORM, List<String>?>>? conjugateMood(
    String verb,
    MOOD mood, [
    bool allForms = false,
  ]) {
    Map<TENSE, Map<FORM, List<String>?>> conjugatedTenses = {};

    for (TENSE tense in mood.tenses) {
      Map<FORM, List<String>?>? t = conjugateTense(verb, mood, tense, allForms);
      if (t != null) {
        conjugatedTenses[tense] = t;
      }
    }

    if (conjugatedTenses.isEmpty) {
      return null;
    } else {
      return conjugatedTenses;
    }
  }

  Map<MOOD, Map<TENSE, Map<FORM, List<String>?>>>? conjugateVerb(
    String verb, [
    bool allForms = false,
  ]) {
    Map<MOOD, Map<TENSE, Map<FORM, List<String>?>>> conjugatedVerb = {};

    for (MOOD mood in MOOD.values) {
      Map<TENSE, Map<FORM, List<String>?>>? m = conjugateMood(
        verb,
        mood,
        allForms,
      );
      if (m != null) {
        conjugatedVerb[mood] = m;
      }
    }

    if (conjugatedVerb.isEmpty) {
      return null;
    } else {
      return conjugatedVerb;
    }
  }

  Verb getRandomVerb() {
    final rand = Random();
    final index = rand.nextInt(verbs.length);
    return verbs.values.elementAt(index);
  }

  Map<String, dynamic> getQuestion() {
    final verb = getRandomVerb();
    final conjugated = conjugateVerb(verb.verb, true);

    final rand = Random();
    // Select a random mood
    List<MOOD> moods = conjugated!.keys.toList();
    MOOD mood = moods[rand.nextInt(moods.length)];

    // Select a random tense
    List<TENSE> tenses = conjugated[mood]!.keys.toList();
    TENSE tense = tenses[rand.nextInt(tenses.length)];

    // Select a random form
    List<FORM> forms = conjugated[mood]![tense]!.keys.toList();
    FORM form = forms[rand.nextInt(forms.length)];

    // Get the conjugated variants
    Map<String, dynamic> question = {
      "verb": verb,
      "mood": mood,
      "tense": tense,
      "form": form,
      "conjugation": conjugated[mood]![tense]![form],
    };

    return question;
  }

  // private constructor
  Dictionary._();

  static Future<Dictionary> load() async {
    final dict = Dictionary._();

    final verbsJsonString = await rootBundle.loadString(dict.verbsFile);
    final verbsJson = jsonDecode(verbsJsonString);
    dict.verbs = dict._parseVerbs(verbsJson);

    final conjugationsJsonString = await rootBundle.loadString(
      dict.conjugationsFile,
    );
    final conjugationsJson = jsonDecode(conjugationsJsonString);
    dict.conjugations = dict._parseConjugations(conjugationsJson);

    return dict;
  }
}
