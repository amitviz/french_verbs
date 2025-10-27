import "mood.dart";

class Conjugation {
  Conjugation({required this.moods});

  final Map<String, Mood> moods;

  factory Conjugation.fromJson(Map<String, dynamic> data) {
    final moods = <String, Mood>{};
    // each key in data is a mood name that maps to a map of tenses
    data.forEach((moodName, moodValue) {
      if (moodValue is Map<String, dynamic>) {
        moods[moodName] = Mood.fromJson(moodValue);
      }
    });

    return Conjugation(moods: moods);
  }
}
