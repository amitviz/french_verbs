class Term {
  Term({required this.verbs});

  final List<String> verbs;

  /// Creates a Term from JSON data.
  ///
  /// The reverse dictionary stores values as a plain list of verb strings, e.g.
  /// "abaissassiez": ["abaisser"]
  ///
  /// But other code paths may supply a Map with a 'verbs' key. Accept both.
  factory Term.fromJson(dynamic data) {
    if (data is List) {
      return Term(verbs: List<String>.from(data));
    }

    if (data is Map<String, dynamic>) {
      final verbs = List<String>.from(data['verbs'] as List);
      return Term(verbs: verbs);
    }

    throw FormatException('Unexpected Term JSON: ${data.runtimeType}');
  }
}
