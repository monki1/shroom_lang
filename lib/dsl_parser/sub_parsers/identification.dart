import 'package:petitparser/petitparser.dart';
import 'identifier.dart';

// Define the parser for a path
Parser path() {
  return identifier().plusSeparated(char('.'));
}

// Define the parser for an integer identifier
Parser integerId() {
  return digit().plus().flatten();
}

// Define the parser for identification
Parser identification() {
  return (path() | integerId()).flatten();
}

Parser key() {
  return identifier().trim();
}