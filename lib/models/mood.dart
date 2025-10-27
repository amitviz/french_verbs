import "tense.dart";

class Mood {
  Mood({required this.tenses});

  final Map<String, Tense> tenses;

  factory Mood.fromJson(Map<String, dynamic> data) {
    final tenses = <String, Tense>{};
    data.forEach((tenseName, tenseValue) {
      if (tenseValue is List) {
        tenses[tenseName] = Tense.fromJson(tenseValue);
      }
    });
    return Mood(tenses: tenses);
  }
}
