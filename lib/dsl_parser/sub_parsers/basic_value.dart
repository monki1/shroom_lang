import 'package:petitparser/petitparser.dart';
import 'package:shroom_lang/dsl_parser/sub_parsers/identifier.dart';

Parser integer() {
  //print('integer');
  return digit()
      .plus()
      .flatten()
      .map((value) => {"type": "int", "value": int.parse(value)});
}

Parser float() {
  //print('float');
  return (digit().plus() & char('.') & digit().plus()).flatten().map((value) {
    return {"type": "float", "value": double.parse(value)};
  });
}

Parser sTring() {
  return (char('"') & any().starLazy(char('"')) & char('"')).flatten().map(
          (value) => {
                "type": "string",
                "value": value.substring(1, value.length - 1)
              }) // Remove the quotes
      |
      identifier().flatten().map((value) => {"type": "string", "value": value});
}
