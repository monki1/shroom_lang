import 'package:petitparser/petitparser.dart';
import 'package:test/test.dart';
import 'package:shroom_lang/dsl_parser/dsl_parser.dart'; 

void main() async{
  group('DSL Parser Tests', () {
    late Parser parser;

    setUp(() {

      parser = DSLParserDefinition().build();
    });

    test('Parser Initialization', () {
      expect(parser, isNotNull); // Basic test to check if the parser is created
    });

  });
}
