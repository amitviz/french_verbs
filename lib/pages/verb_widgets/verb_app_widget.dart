import "package:flutter/material.dart";
import "package:french_verbs/pages/verb_widgets/verb_display.dart";
import "package:french_verbs/pages/verb_widgets/definition.dart";
import "package:french_verbs/pages/verb_widgets/mood.dart";
import "package:french_verbs/pages/verb_widgets/tense.dart";
import "package:french_verbs/pages/verb_widgets/person.dart";
import "package:french_verbs/pages/verb_widgets/input.dart";
import "package:french_verbs/pages/verb_widgets/input_button.dart";
import "package:french_verbs/models/dictionary.dart";
import "package:french_verbs/main.dart"; // for routeObserver

class VerbAppWidget extends StatefulWidget {
  const VerbAppWidget({super.key});

  @override
  State<VerbAppWidget> createState() => _VerbAppWidgetState();
}

class _VerbAppWidgetState extends State<VerbAppWidget> with RouteAware {
  // App has two modes:
  //   - question mode: shows the user a verb to conjugate
  //   - answer mode: shows the correct conjugation for the verb
  bool _questionMode = false;

  // Current verb infinitive to conjugate
  String _verb = "";
  String _definition = "";
  // Whether the definition is revealed - toggleable by the user
  bool _definitionIsRevealed = false;

  String _mood = "";
  String _tense = "";
  String _person = "";
  String _pronoun = "";

  List<String> _correctAnswers = [];

  bool? _correct;
  String? _errorText;

  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();

  // final dictionary = await Dictionary.load();
  Dictionary? dictionary;
  bool _dictionaryLoaded = false;

  void _onReappear() {
    // When the widget reappears (e.g. after navigating back to it)
    dictionary!.refreshSelectedVerbs();
  }

  void _handleDefinitionToggle() {
    setState(() {
      _definitionIsRevealed = !_definitionIsRevealed;
    });
  }

  void _handleSubmit() {
    // Depending on state - checks the answer, or loads up a new question
    setState(() {
      _questionMode = !_questionMode;
    });

    if (_questionMode) {
      // Question mode - Load a new verb to conjugate

      if (!_dictionaryLoaded || dictionary == null) {
        // dictionary not ready yet
        return;
      }

      final q = dictionary!.getQuestion();
      // debugPrint('Expected answer(s): ${q['conjugation']}');

      setState(() {
        _verb = q['verb'].verb;
        _definition =
            q['verb'].definitions.join(" • ") ?? 'No definition available';
        _definitionIsRevealed = false;
        _mood = q['mood'].french;
        _tense = q['tense'].french;
        _person = q['form'].french;
        _pronoun = q['form'].prefix;
        _correctAnswers = q['conjugation'];
        _correct = null;
        _errorText = null;

        // Clear the input field
        _inputController.text = "";
        _inputFocusNode.requestFocus();
      });
    } else {
      // Answer mode - check the answer and reveal the definition

      final isCorrect = _correctAnswers.any(
        (ans) => ans.trim().toLowerCase() == _inputController.text,
      );

      setState(() {
        _definitionIsRevealed = true;
        _inputFocusNode.requestFocus();

        if (_inputController.text.isEmpty) {
          _inputController.text = _correctAnswers.join(" / ");
          _correct = null;
        } else {
          _correct = isCorrect;
          if (!isCorrect) {
            _errorText = _correctAnswers.join(" / ");
          } else {
            _errorText = null;
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Load dictionary, then run _handleSubmit once the first frame is ready.
    Dictionary.load().then((dict) {
      dictionary = dict;
      _dictionaryLoaded = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _handleSubmit());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _inputController.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when another route above this one has been popped
    super.didPopNext();
    _onReappear();
  }

  @override
  Widget build(BuildContext context) {
    Column w = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        VerbDisplayWidget(verb: _verb, onTap: _handleDefinitionToggle),
        DefinitionWidget(
          definition: _definition,
          isRevealed: _definitionIsRevealed,
          onTap: _handleDefinitionToggle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoodWidget(mood: _mood),
            TenseWidget(tense: _tense),
            PersonWidget(person: _person),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputWidget(
                  controller: _inputController,
                  focusNode: _inputFocusNode,
                  onSubmit: _handleSubmit,
                  pronoun: _pronoun,
                  correct: _correct,
                  errorText: _errorText,
                ),
              ),
            ),
            InputButtonWidget(onSubmit: _handleSubmit),
          ],
        ),
      ],
    );
    return w;
  }
}
