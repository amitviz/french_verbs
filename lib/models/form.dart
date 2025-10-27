class Form {
  Form({required this.variants});

  final List<String> variants;

  factory Form.fromJson(List<dynamic> data) {
    // Each element in data is expected to be a string variant
    return Form(variants: List<String>.from(data));
  }
}
