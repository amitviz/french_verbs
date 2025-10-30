import "package:flutter/material.dart";
import "package:french_verbs/models/reverse_dictionary.dart";
import "package:french_verbs/models/term.dart";
import "package:french_verbs/pages/dictionary_widgets/input.dart";
import "package:french_verbs/pages/dictionary_widgets/input_button.dart";

class DictionaryAppWidget extends StatefulWidget {
  const DictionaryAppWidget({super.key});

  @override
  State<DictionaryAppWidget> createState() => _DictionaryAppWidgetState();
}

class _DictionaryAppWidgetState extends State<DictionaryAppWidget> {
  ReverseDictionary? rDictionary;
  bool _rDictionaryLoaded = false;
  String? _errorText;
  String? _currentVerb;
  // List<String> _matchedKeys = [];
  // List<String> _resultVerbs = [];
  // String? _message;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    ReverseDictionary.load().then((rDict) {
      setState(() {
        rDictionary = rDict;
        _rDictionaryLoaded = true;
      });
    });
  }

  void _handleSubmit() {
    String searchTerm = _searchController.text.toLowerCase();
    List<String>? candidateVerbs = rDictionary?.terms[searchTerm]?.verbs;

    if (candidateVerbs != null) {
      setState(() {
        _errorText = null;
      });
      if (candidateVerbs.length == 1) {
        setState(() {
          _currentVerb = candidateVerbs[0];
        });
      } else {
        // more than one possible verb
        debugPrint('Multiple possible verbs found: $candidateVerbs');
      }
    } else {
      setState(() {
        _errorText = "No matching term found.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputWidget(
              controller: _searchController,
              focusNode: _inputFocusNode,
              onSubmit: _handleSubmit,
              errorText: _errorText,
            ),
          ),
        ),
        InputButtonWidget(onSubmit: _handleSubmit),
      ],
    );
  }
}
