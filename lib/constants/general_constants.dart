import 'dart:core';

// regular expression to match the non domain part of an email
final regExp = RegExp(
  r"^([^@]+)",
);

// This is to indicate if you have firebase emulator suite.
// TODO: Updaate the readme for this
final usingEmulator =
    (const String.fromEnvironment('PREVIEW', defaultValue: 'FALSE') == "TRUE");
