import 'package:petitparser/petitparser.dart';
import 'package:test/test.dart';
import 'package:shroom_lang/dsl_parser/dsl_parser.dart'; // Adjust the import path if necessary

void main() {
  group('DSL Parser Tests', () {
    late Parser parser;

    setUp(() {
      // Initialize parser before each test
      parser = DSLParserDefinition().build();
    });
  });
}
