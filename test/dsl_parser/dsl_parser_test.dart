import 'dart:convert';
import 'package:petitparser/petitparser.dart';
import 'package:test/test.dart';
import 'package:shroom_lang/dsl_parser/dsl_parser.dart';
import 'example.dart'; // Import the updated example

void main() async {
  group('DSL Parser Tests', () {
    late DSLParserDefinition parser;

    setUp(() {
      parser = DSLParserDefinition();
    });

    test('Parser Initialization', () {
      expect(parser, isNotNull); // Basic test to check if the parser is created
    });

    test('Parsing Examples', () {
      EXAMPLES.forEach((input, expectedOutput) {
        final result = parser.build().parse(input);
        expect(result is Success, true);

        // Convert the parsed output to JSON and compare with expected JSON
        expect(jsonDecode(jsonEncode(result.value)), equals(jsonDecode(jsonEncode([expectedOutput]))));
      });
    });
  });
}
