class Verb {
  Verb({
    required this.verb,
    required this.type,
    required this.definitions,
    required this.auxiliary,
  });
  final String verb;
  final String type;
  final List<String> definitions;
  final String auxiliary;

  factory Verb.fromJson(Map<String, dynamic> data) {
    final verb = data['verb'] as String;
    final type = data['type'] as String;
    final definitions = List<String>.from(data['definitions'] as List);
    final auxiliary = data['auxiliary'] as String;
    return Verb(
      verb: verb,
      type: type,
      definitions: definitions,
      auxiliary: auxiliary,
    );
  }
}
