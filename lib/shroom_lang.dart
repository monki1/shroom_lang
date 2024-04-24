import 'package:petitparser/petitparser.dart';

import 'dsl_parser/dsl_parser.dart';

class ShroomLang {
  static final parser = DSLParserDefinition().build();

  static dynamic parse(String input) {
    Result? value;
    try {
      value = parser.parse(input);
      return value is Success ? value.value : null;
    } catch (e) {
      print('Parsing failed: $input');
      print('Error: $e');
      print('Error: ${value?.message} at position ${value?.position}');
    }
    return null;
  }
}
