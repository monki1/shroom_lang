import 'package:petitparser/petitparser.dart';
import 'identifier.dart';

// Define the parser for a path
Parser<Map<String, dynamic>> path() {
  return identifier().plusSeparated(char('.')).map((list) => 
    {"type": "path", "value": list.elements}
  );
}

// Define the parser for an integer identifier
Parser<Map<String, dynamic>> integerId() {
  return digit().plus().flatten().map((string) => 
    {"type": "id", "value": int.parse(string)}
  );
}

// Define the parser for identification
Parser<Map<String, dynamic>> identification() {
  return (path() | integerId()).cast<Map<String, dynamic>>();
}

Parser<String> key() {
  // This parser returns a string, which is just the flattened result of an identifier, trimmed.
  return identifier().trim().flatten();
}
