import 'package:petitparser/petitparser.dart';
import 'identifier.dart';

// Define the parser for a path
Parser<Map<String, dynamic>> path() {
  return identifier()
      .plusSeparated(char('.'))
      .map((list) => {"type": "path", "value": list.elements});
}

// Define the parser for an integer identifier
Parser<Map<String, dynamic>> integerId() {
  return digit()
      .plus()
      .flatten()
      .map((string) => {"type": "id", "value": int.parse(string)});
}

// Define the parser for identification
Parser<Map<String, dynamic>> identification() {
  return (path() | integerId()).cast<Map<String, dynamic>>();
}

Parser<String> key() {
  // This parser returns a string, which is just the flattened result of an identifier, trimmed.
  return identifier().trim().map((value) => value.trim());
}

Parser<List<String>> keyList() {
  return (char(':').trim() & key().plusSeparated(char(':').trim())).map((list) {
    final values = (list[1] as SeparatedList).elements;
    return values as List<String>;
  });
}



// void testKeyListParser() {
//   final input = ': key1:key2   :key3';
//   final result = keyList().parse(input);
//   if (result is Success) {
//     final List<String> keys = result.value;
//     print(keys); // Output: ['key1', 'key2', 'key3']
//     // You can add more detailed assertions here if needed
//   } else {
//     print('Parsing failed');
//   }
// }

// void main() {
//   testKeyListParser();
// }
