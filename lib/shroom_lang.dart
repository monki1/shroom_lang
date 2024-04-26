import 'dart:convert';

import 'package:petitparser/petitparser.dart';

import 'dsl_parser/dsl_parser.dart';

class ShroomLang {
  static final parser = DSLParserDefinition().build();

  static List<Map<String, dynamic>>? parse(String input) {
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

void main (){

  List<dynamic>? result = ShroomLang.parse('+id123 profile:{address:{city:NewYork state:NY}}');

print(result);
for( var value in result!){
  print('Result: ${value} ${value.runtimeType}');
}
  print(result);
  print('Result: ${JsonEncoder.withIndent('  ').convert(result)}');


}
