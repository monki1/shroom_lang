import 'package:petitparser/petitparser.dart';

Parser identifier() {
  // Parser for identifiers: starts with a letter and followed by zero or more word characters
  return (letter() & word().star()).flatten();
}
