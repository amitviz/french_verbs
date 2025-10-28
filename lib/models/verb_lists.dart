import 'dart:convert';
import "verb_list.dart";

class VerbLists {
  VerbLists({required this.verbLists});

  final Map<String, VerbList> verbLists;

  factory VerbLists.fromJson(dynamic data) {
    dynamic decoded = data;
    if (data is String) {
      decoded = json.decode(data);
    }

    if (decoded is Map) {
      final Map<String, VerbList> lists = {};
      decoded.forEach((key, value) {
        lists[key.toString()] = VerbList.fromJson(value);
      });
      return VerbLists(verbLists: lists);
    }

    throw ArgumentError('Unsupported JSON for VerbLists: $data');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> out = {};
    verbLists.forEach((key, value) {
      out[key] = value.toJson();
    });
    return out;
  }
}
