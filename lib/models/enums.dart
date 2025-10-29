enum FORM {
  infinitive(value: 0, french: "", prefix: ""),
  je(value: 0, french: "je", prefix: "je ", participleForm: FORM.participle),
  tu(value: 1, french: "tu", prefix: "tu ", participleForm: FORM.participle),
  il(
    value: 2,
    french: "il",
    prefix: "il ",
    participleForm: FORM.participleMasculineSingular,
  ),
  elle(
    value: 2,
    french: "elle",
    prefix: "elle ",
    participleForm: FORM.participleFeminineSingular,
  ),
  on(value: 2, french: "on", prefix: "on ", participleForm: FORM.participle),
  ilElleOn(
    value: 2,
    french: "il/elle/on",
    prefix: "",
    participleForm: FORM.participle,
  ),
  nous(
    value: 3,
    french: "nous",
    prefix: "nous ",
    participleForm: FORM.participleMasculinePlural,
  ),
  vous(
    value: 4,
    french: "vous",
    prefix: "vous ",
    participleForm: FORM.participleMasculinePlural,
  ),
  ils(
    value: 5,
    french: "ils",
    prefix: "ils ",
    participleForm: FORM.participleMasculinePlural,
  ),
  elles(
    value: 5,
    french: "elles",
    prefix: "elles ",
    participleForm: FORM.participleFemininePlural,
  ),
  ilsElles(
    value: 5,
    french: "ils/elles",
    prefix: "",
    participleForm: FORM.participleMasculinePlural,
  ),
  imperativeTu(
    value: 0,
    french: "(tu)",
    prefix: "",
    participleForm: FORM.participle,
  ),
  imperativeNous(
    value: 1,
    french: "(nous)",
    prefix: "",
    participleForm: FORM.participleMasculinePlural,
  ),
  imperativeVous(
    value: 2,
    french: "(vous)",
    prefix: "",
    participleForm: FORM.participleMasculinePlural,
  ),
  gerund(value: 0, french: "", prefix: ""),
  participle(value: 0, french: "", prefix: ""),
  participleMasculineSingular(value: 0, french: "(m.)", prefix: ""),
  participleFeminineSingular(value: 2, french: "(f.)", prefix: ""),
  participleMasculinePlural(value: 1, french: "(m.pl.)", prefix: ""),
  participleFemininePlural(value: 3, french: "(f.pl.)", prefix: "");

  const FORM({
    required this.value,
    required this.french,
    required this.prefix,
    this.participleForm,
  });

  final int value;
  final String french;
  final String prefix;
  final FORM? participleForm;
}

enum TENSE {
  infinitive(
    value: 'infinitive-present',
    french: "présent",
    forms: [FORM.infinitive],
    conjugationForms: [FORM.infinitive],
  ),
  present(
    value: 'present',
    french: "présent",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  passecompose(
    value: 'passecompose',
    french: "passé composé",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  passe(
    value: 'passe',
    french: "passé",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  futurproche(
    value: 'futurproche',
    french: "futur proche",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  passerecent(
    value: 'passerecent',
    french: "passé récent",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  imperfect(
    value: 'imperfect',
    french: "imparfait",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  future(
    value: 'future',
    french: "futur",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  pastSimple(
    value: 'simple-past',
    french: "passé simple",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  plusqueparfait(
    value: 'plusqueparfait',
    french: "plus-que-parfait",
    forms: [
      FORM.je,
      FORM.tu,
      FORM.il,
      FORM.elle,
      FORM.on,
      FORM.nous,
      FORM.vous,
      FORM.ils,
      FORM.elles,
    ],
    conjugationForms: [
      FORM.je,
      FORM.tu,
      FORM.ilElleOn,
      FORM.nous,
      FORM.vous,
      FORM.ilsElles,
    ],
  ),
  imperative(
    value: 'imperative-present',
    french: "présent",
    forms: [FORM.imperativeTu, FORM.imperativeNous, FORM.imperativeVous],
    conjugationForms: [
      FORM.imperativeTu,
      FORM.imperativeNous,
      FORM.imperativeVous,
    ],
  ),
  imperativepasse(
    value: 'imperative-passe',
    french: "passé",
    forms: [FORM.imperativeTu, FORM.imperativeNous, FORM.imperativeVous],
    conjugationForms: [
      FORM.imperativeTu,
      FORM.imperativeNous,
      FORM.imperativeVous,
    ],
  ),
  participlePresent(
    value: 'present-participle',
    french: "gérondif",
    forms: [FORM.gerund],
    conjugationForms: [FORM.gerund],
  ),
  participlePast(
    value: 'past-participle',
    french: "passé",
    forms: [
      FORM.participleMasculineSingular,
      FORM.participleMasculinePlural,
      FORM.participleFeminineSingular,
      FORM.participleFemininePlural,
    ],
    conjugationForms: [FORM.participle],
  );

  const TENSE({
    required this.value,
    required this.french,
    required this.forms,
    required this.conjugationForms,
  });

  final String value;
  final String french;
  // All the individual forms available in this tense:
  final List<FORM> forms;
  // The forms used to list a full conjugation:
  final List<FORM> conjugationForms;
}

enum MOOD {
  infinitive(
    value: 'infinitive',
    french: "infinitif",
    tenses: [TENSE.infinitive],
  ),
  indicative(
    value: 'indicative',
    french: "indicatif",
    tenses: [
      TENSE.present,
      TENSE.passecompose,
      TENSE.futurproche,
      TENSE.passerecent,
      TENSE.imperfect,
      TENSE.future,
      TENSE.pastSimple,
      TENSE.plusqueparfait,
    ],
  ),
  imperative(
    value: 'imperative',
    french: "impératif",
    tenses: [TENSE.imperative, TENSE.imperativepasse],
  ),
  participle(
    value: 'participle',
    french: "participe",
    tenses: [TENSE.participlePresent, TENSE.participlePast],
  ),
  conditional(
    value: 'conditional',
    french: "conditionnel",
    tenses: [TENSE.present, TENSE.passe],
  ),
  subjunctive(
    value: 'subjunctive',
    french: "subjonctif",
    tenses: [TENSE.present, TENSE.imperfect, TENSE.passe],
  );

  const MOOD({required this.value, required this.french, required this.tenses});

  final String value;
  final String french;
  final List<TENSE> tenses;
}
