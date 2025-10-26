// import "package:flutter/material.dart";

// Basic function to check if a string starts with a vowel (for French elision)
bool startsWithVowel(String s) {
  s = s.trimLeft();
  if (s.isEmpty) return false;
  final c = s[0].toLowerCase();
  const vowels = "aàâäeéèêëhiîïoöuùûüyÿ";
  return vowels.contains(c);
}
