import "package:flutter/material.dart";
import "package:french_verbs/utilities/utilities.dart";

// Input field for the user to type the conjugated verb
class InputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback onSubmit;
  final String pronoun;
  final bool? correct;
  final String? errorText;
  const InputWidget({
    super.key,
    this.controller,
    this.focusNode,
    required this.onSubmit,
    required this.pronoun,
    this.correct,
    this.errorText,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  String userInput = "";
  // use the passed controller or create one
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  @override
  void dispose() {
    // only dispose if we created it locally
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userInput = _controller.text;
    bool? isUserCorrect = widget.correct;
    Icon? suffixIcon;
    if (isUserCorrect == true) {
      suffixIcon = Icon(Icons.check_circle, color: Colors.green);
    } else if (isUserCorrect == false) {
      suffixIcon = Icon(Icons.cancel, color: Colors.red);
    } else {
      suffixIcon = null;
    }
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      onChanged: (value) {
        setState(() {
          userInput = value;
        });
      },
      onSubmitted: (_) => widget.onSubmit(),
      autofocus: true,
      decoration: InputDecoration(
        labelText: "",
        border: OutlineInputBorder(),
        prefixText: _prefixText(),
        suffixIcon: suffixIcon,
        errorText: widget.errorText,
      ),
    );
  }

  String _prefixText() {
    if (widget.pronoun == "je " && startsWithVowel(userInput)) {
      return "j'";
    } else {
      return widget.pronoun;
    }
  }
}
