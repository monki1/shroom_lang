import 'package:petitparser/petitparser.dart';
import 'package:shroom_lang/dsl_parser/sub_parsers/sub_parsers.dart';
class DSLParserDefinition extends GrammarDefinition {
  @override
  Parser start() {
    //print('start');
    return ref0(document).end();
  }

  Parser document() {
    //print('document');
    return ref0(statement).star();
  }

  Parser statement() {
    //print('statement');
    return ref0(createOp) | ref0(readOp) | ref0(updateOp) | ref0(deleteOp);
  }

  // Create operation parser: Identification is optional
  Parser createOp() {
    //print('createOp');
    return char('+').trim()  & ref0(path).optional() & ref0(attributes).optional();
  }

  // Read operation parser: Identification is required, optional key
  Parser readOp() {
    //print('readOp');
    return char('@').trim() & ref0(identification) & (char(':').trim() & ref0(key)).optional();
  }

  // Update operation parser: Attributes are optional
  Parser updateOp() {
    //print('updateOp');
    return char('^').trim()  & ref0(identification) & ref0(attributes).optional();
  }

  // Delete operation parser: Identification is required, optional key
  Parser deleteOp() {
    //print('deleteOp');
    return char('-').trim()  & ref0(identification) & (char(':').trim() & ref0(key)).optional();
  }

  Parser keyValue() {
  return key().trim() & char(':').trim() & ref0(value);
}


Parser value() {
  // Use the '|' operator to combine multiple parsers
  return integer() | float() | sTring() | nodeReference() | ref0(node) | ref0(list);
}

Parser node() {
  return char('{').trim() & ref0(attributes).trim() & char('}');
}

Parser list() {
  return char('[').trim() & value().plusSeparated(whitespace()).trim() & char(']');
}

Parser attributes() {
  return keyValue().plusSeparated(whitespace());
}




}
