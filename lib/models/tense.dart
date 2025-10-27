import "form.dart";

class Tense {
  Tense({required this.forms});

  // Each form is a list of variant strings
  final List<Form> forms;

  factory Tense.fromJson(List<dynamic> data) {
    final forms = <Form>[];
    for (final formItem in data) {
      if (formItem is List) {
        forms.add(Form.fromJson(formItem));
      }
    }
    return Tense(forms: forms);
  }
}
