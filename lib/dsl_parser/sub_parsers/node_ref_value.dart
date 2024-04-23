
import 'package:petitparser/petitparser.dart';
import 'identification.dart';
Parser<Map<String, dynamic>> nodeReference() {
  // Define the parser that starts with '@' and is followed by an identification
  return (char('@') & identification()).map((list) {
    // 'list' here contains ["@", result of identification]
    // You want to transform this into a structured map
    return {
      "type": "node_ref",
      "value": list[1]  // 'list[1]' is the result of the identification parser
    };
  });
}