// import 'package:petitparser/petitparser.dart';
// import 'sub_parsers/identifier.dart';
// import 'sub_parsers/basic_value.dart';
// import 'sub_parsers/identification.dart';
// import 'sub_parsers/node_ref_value.dart';

// import 'package:petitparser/petitparser.dart';
import 'package:petitparser/petitparser.dart';

import 'dsl_parser.dart';  // Correct import path if necessary

void main() {
  // Create an instance of your DSLParserDefinition
  final parser = DSLParserDefinition().build();

  // Define a list of test strings to parse
  List<String> tests = [
    // '+id123.abc address:{city:NewYork state:NY}',
    // '+id123 address: {city:NewYork state:NY friends:[@idstr @123]}',
    // '+id123 friends:[{name:John age:25} {name:Jane age:30 friends:[@idstr @123] enemies:[@idstr @123]}]',
    '+id123 friends:[ {name:John age:25 }     {name:Jane age:30 friends:[@idstr @123] enemies:[@idstr @123 ]} ]',

    // '+id123 profile:{address:{city:NewYork state:NY}}',
    // '+id123 name:John age:25 status:active friends:[@idstr @123 @sajo] year:2021',
    // '@id123:name',
    // '^ id123 profile : {name:Jane} friends:[@idstr @123]',
    // '- id123',

  ];

  // Parse each string and print the results
  for (var test in tests) {
    final result = parser.parse(test);
    if (result is Success) {
      print('Parsing success: $test');
      print('Result: ${result.value}');
    } else {
      print('Parsing failed: $test');
      print('Error: ${result.message} at position ${result.position}');
    }
  }
}
