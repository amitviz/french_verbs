import "package:flutter/material.dart";
import "package:french_verbs/models/dictionary.dart";
import "package:french_verbs/models/reverse_dictionary.dart";
import "package:french_verbs/pages/common_widgets/conjugation_table.dart";
import "package:french_verbs/pages/dictionary_widgets/input.dart";
import "package:french_verbs/pages/dictionary_widgets/input_button.dart";
import "package:french_verbs/pages/verb_widgets/verb_display.dart";
import "package:french_verbs/pages/verb_widgets/definition.dart";
import "package:french_verbs/models/enums.dart";

class DictionaryAppWidget extends StatefulWidget {
  const DictionaryAppWidget({super.key});

  @override
  State<DictionaryAppWidget> createState() => _DictionaryAppWidgetState();
}

class _DictionaryAppWidgetState extends State<DictionaryAppWidget> {
  ReverseDictionary? rDictionary;
  // bool _rDictionaryLoaded = false;
  Dictionary? dictionary;
  // bool _dictionaryLoaded = false;
  String? _errorText;
  String? _currentVerb;
  String _definition = "";
  bool _definitionIsRevealed = false;
  Widget? _conjugations;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();
  final GlobalKey _inputKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    ReverseDictionary.load().then((rDict) {
      setState(() {
        rDictionary = rDict;
        // _rDictionaryLoaded = true;
      });
    });
    Dictionary.load().then((dict) {
      setState(() {
        dictionary = dict;
        // _dictionaryLoaded = true;
      });
    });
  }

  void _handleSubmit() {
    String searchTerm = _searchController.text.trim().toLowerCase();
    List<String>? candidateVerbs = rDictionary?.terms[searchTerm]?.verbs;

    if (candidateVerbs != null) {
      if (candidateVerbs.length == 1) {
        setState(() {
          _errorText = null;
          _currentVerb = candidateVerbs[0];
          _definition =
              dictionary?.verbs[_currentVerb!]?.definitions.join(" • ") ??
              "No definition available";
          _definitionIsRevealed = true;
        });
        _buildConjugations();
      } else {
        // more than one possible verb: show a dropdown below the input
        _inputFocusNode.unfocus();

        // compute the position of the input widget so we can anchor the menu
        if (_inputKey.currentContext != null) {
          final RenderBox box =
              _inputKey.currentContext!.findRenderObject() as RenderBox;
          final Offset position = box.localToGlobal(Offset.zero);
          final RelativeRect positionRect = RelativeRect.fromLTRB(
            position.dx,
            position.dy + box.size.height,
            position.dx + box.size.width,
            position.dy,
          );

          showMenu<String>(
            context: context,
            position: positionRect,
            items: candidateVerbs.map((verb) {
              return PopupMenuItem<String>(value: verb, child: Text(verb));
            }).toList(),
          ).then((selected) {
            if (selected != null) {
              setState(() {
                _errorText = null;
                _currentVerb = selected;
                _definition =
                    dictionary?.verbs[_currentVerb!]?.definitions.join(" • ") ??
                    "No definition available";
                _definitionIsRevealed = true;
              });
              _buildConjugations();
            }
          });
        } else {
          // fallback: if we can't compute position, log and pick first
          debugPrint('Could not determine input position for dropdown.');
        }
      }
    } else {
      setState(() {
        _errorText = "No matching verbs found.";
      });
    }
  }

  void _buildConjugations() {
    Map<MOOD, Map<TENSE, Map<FORM, List<String>?>>>? currentConjugation =
        dictionary?.conjugateVerb(_currentVerb ?? "");

    // Build a mutable list of children first, then construct the Column.
    List<Widget> conjugationChildren = [];
    currentConjugation?.forEach((mood, moodMap) {
      // conjugationChildren.add(
      //   Padding(
      //     padding: const EdgeInsets.only(top: 40.0),
      //     child: Text(
      //       mood.french,
      //       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // );
      List<Widget> gridViewChildren = [];
      moodMap.forEach((tense, tenseMap) {
        gridViewChildren.add(
          ConjugationTable(
            conjugatedTense: tenseMap,
            mood: mood,
            title: tense.french,
          ),
        );
      });

      double aspectRatio = 0.6;
      if ([MOOD.imperative].contains(mood)) {
        aspectRatio = 1.0;
      } else if ([MOOD.participle, MOOD.infinitive].contains(mood)) {
        aspectRatio = 3.0;
      }

      conjugationChildren.add(
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              mood.french,
              style: TextStyle(
                // fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            initiallyExpanded: true,
            children: [
              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 2,
                childAspectRatio: aspectRatio,
                children: gridViewChildren,
              ),
            ],
          ),
        ),
      );
    });
    setState(() {
      _conjugations = Column(children: conjugationChildren);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputWidget(
                  key: _inputKey,
                  controller: _searchController,
                  focusNode: _inputFocusNode,
                  onSubmit: _handleSubmit,
                  errorText: _errorText,
                ),
              ),
            ),
            InputButtonWidget(onSubmit: _handleSubmit),
          ],
        ),
        VerbDisplayWidget(verb: _currentVerb ?? "", onTap: () {}),
        DefinitionWidget(
          definition: _definition,
          isRevealed: _definitionIsRevealed,
          onTap: () {},
        ),
        _conjugations ?? Container(),
      ],
    );
  }
}
