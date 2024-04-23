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

Parser<Map<String, dynamic>> keyValue() {
  return (key().trim() & char(':').trim() & ref0(value)).map((list) {
    var key = list[0] as String;       // Extract the key (first element)
    var value = list[2];               // Extract the value (third element)
    return {key: value};               // Create a map with the key and value
  });
}

Parser value() {
  // Use the '|' operator to combine multiple parsers
  return integer() | float() | sTring() | nodeReference() | ref0(node) | ref0(list);
}

Parser<Map<String, dynamic>> node() {
  return (char('{').trim() & ref0(attributes).trim() & char('}')).map((list) {
    // Extract the attributes part which is a Map<String, dynamic>
    var attributesMap = list[1] as Map<String, dynamic>;
    // Return the structured node map
    return {"type": "node", "value": attributesMap};
  });
}

Parser<Map<String, dynamic>> list() {
  return (char('[').trim() & value().plusSeparated(whitespace()).trim() & char(']')).map((list) {
    // Extract the second element from the list which contains the SeparatedList of values.
    var values = list[1] as SeparatedList;
    // Return the elements part which is a List of parsed values.
    return {
      "type": "list",
      "value": values.elements
    };
  });
}

Parser<Map<String, dynamic>> attributes() {
  return keyValue().plusSeparated(whitespace()).map((kvSeparatedList) {
    // Use foldLeft to merge all the maps into one, ignoring separators
    return kvSeparatedList.foldLeft(
      (combinedMap, _, currentMap) {
      combinedMap.addAll(currentMap);
      return combinedMap;
    });
  });
}



}
