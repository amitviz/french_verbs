enum FORM {
  infinitive(value: 0, french: "", prefix: ""),
  je(value: 0, french: "je", prefix: "je "),
  tu(value: 1, french: "tu", prefix: "tu "),
  il(value: 2, french: "il", prefix: "il "),
  elle(value: 2, french: "elle", prefix: "elle "),
  on(value: 2, french: "on", prefix: "on "),
  ilElleOn(value: 2, french: "il/elle/on", prefix: ""),
  nous(value: 3, french: "nous", prefix: "nous "),
  vous(value: 4, french: "vous", prefix: "vous "),
  ils(value: 5, french: "ils", prefix: "ils "),
  elles(value: 5, french: "elles", prefix: "elles "),
  ilsElles(value: 5, french: "ils/elles", prefix: ""),
  imperativeTu(value: 0, french: "(tu)", prefix: ""),
  imperativeNous(value: 1, french: "(nous)", prefix: ""),
  imperativeVous(value: 2, french: "(vous)", prefix: ""),
  gerund(value: 0, french: "", prefix: ""),
  participle(value: 0, french: "", prefix: ""),
  participleMasculineSingular(value: 0, french: "(m.)", prefix: ""),
  participleFeminineSingular(value: 2, french: "(f.)", prefix: ""),
  participleMasculinePlural(value: 1, french: "(m.pl.)", prefix: ""),
  participleFemininePlural(value: 3, french: "(f.pl.)", prefix: "");

  const FORM({required this.value, required this.french, required this.prefix});

  final int value;
  final String french;
  final String prefix;
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
    tenses: [TENSE.present, TENSE.imperfect, TENSE.future, TENSE.pastSimple],
  ),
  conditional(
    value: 'conditional',
    french: "conditionnel",
    tenses: [TENSE.present],
  ),
  subjunctive(
    value: 'subjunctive',
    french: "subjonctif",
    tenses: [TENSE.present, TENSE.imperfect],
  ),
  imperative(
    value: 'imperative',
    french: "impératif",
    tenses: [TENSE.imperative],
  ),
  participle(
    value: 'participle',
    french: "participe",
    tenses: [TENSE.participlePresent, TENSE.participlePast],
  );

  const MOOD({required this.value, required this.french, required this.tenses});

  final String value;
  final String french;
  final List<TENSE> tenses;
}
