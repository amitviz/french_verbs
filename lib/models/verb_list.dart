import 'dart:convert';

class VerbList {
  VerbList({required this.verbs});

  final List<String> verbs;

  factory VerbList.fromJson(dynamic data) {
    dynamic decoded = data;
    if (data is String) {
      decoded = json.decode(data);
    }

    if (decoded is List) {
      return VerbList(verbs: List<String>.from(decoded));
    }

    if (decoded is Map && decoded.containsKey('verbs')) {
      return VerbList(verbs: List<String>.from(decoded['verbs'] as List));
    }

    throw ArgumentError('Unsupported JSON for VerbList: $data');
  }

  dynamic toJson() {
    return verbs;
  }
}
