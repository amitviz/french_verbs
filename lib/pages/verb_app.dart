import "package:flutter/material.dart";
import "package:french_verbs/pages/verb_widgets/verb_display.dart";
import "package:french_verbs/pages/verb_widgets/definition.dart";
import "package:french_verbs/pages/verb_widgets/mood.dart";
import "package:french_verbs/pages/verb_widgets/tense.dart";
import "package:french_verbs/pages/verb_widgets/person.dart";
import "package:french_verbs/pages/verb_widgets/input.dart";
import "package:french_verbs/pages/verb_widgets/input_button.dart";
import "package:french_verbs/models/dictionary.dart";

class VerbApp extends StatelessWidget {
  const VerbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.chat)),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text("Dictionary"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dictionnaire');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: VerbAppWidget(),
    );
  }
}

class VerbAppWidget extends StatefulWidget {
  const VerbAppWidget({super.key});

  @override
  State<VerbAppWidget> createState() => _VerbAppWidgetState();
}

class _VerbAppWidgetState extends State<VerbAppWidget> {
  // App has two modes:
  //   - question mode: shows the user a verb to conjugate
  //   - answer mode: shows the correct conjugation for the verb
  bool _questionMode = false;

  // Current verb infinitive to conjugate
  String _verb = "verbe";
  String _definition = "definition";
  // Whether the definition is revealed - toggleable by the user
  bool _definitionIsRevealed = false;

  String _mood = "indicative";
  String _tense = "present";
  String _person = "je";

  final TextEditingController _inputController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();

  final dictionary = Dictionary.load();

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
    debugPrint("Toggled state: questionMode=$_questionMode");
    if (_questionMode) {
      // Question mode - Load a new verb to conjugate
      dictionary.then((dict) {
        final entry = dict.randomVerb();
        // debugPrint("Selected verb: ${entry.key}");
        // debugPrint("Selected definition: ${entry.value['definitions']}");
        setState(() {
          _verb = entry.key;
          _definition =
              entry.value['definitions'].join(" • ") ??
              'No definition available';
          _definitionIsRevealed = false;

          // For now, we keep mood, tense, person constant here
          _mood = "indicative";
          _tense = "present";
          _person = "je";

          // Clear the input field
          _inputController.text = "";
          _inputFocusNode.requestFocus();
        });
      });
    } else {
      // Answer mode - reveal the definition
      setState(() {
        _definitionIsRevealed = true;
        _inputFocusNode.requestFocus();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Run once after the first frame so _handleSubmit's setState is safe.
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleSubmit());
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputFocusNode.dispose();
    super.dispose();
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
        InputWidget(
          controller: _inputController,
          focusNode: _inputFocusNode,
          onSubmit: _handleSubmit,
        ),
        InputButtonWidget(onSubmit: _handleSubmit),
      ],
    );
    return w;
  }
}
