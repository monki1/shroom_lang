Files and Content:
./test/shroom_lang_test.dart
./CHANGELOG.md
./README.md
./description.md
./pubspec.yaml
./lib/shroom_lang.dart
./lib/dsl_parser/sub_parsers/identifier.dart
./lib/dsl_parser/sub_parsers/identification.dart
./lib/dsl_parser/sub_parsers/sub_parsers.dart
./lib/dsl_parser/sub_parsers/basic_value.dart
./lib/dsl_parser/sub_parsers/node_ref_value.dart
./lib/dsl_parser/test.dart
./lib/dsl_parser/dsl_parser.dart
Content for ./test/shroom_lang_test.dart:
```dart
import 'package:shroom_lang/shroom_lang.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    expect(calculate(), 42);
  });
}
```

Content for ./CHANGELOG.md:
```md
## 1.0.0

- Initial version.
```

Content for ./README.md:
```md
A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.
```

Content for ./description.md:
```md
### DSL Description:

The DSL allows for creating, reading, updating, and deleting nodes in a structured data format. Each operation is represented by a specific character at the beginning of a line: `+` for create, `@` for read, `^` for update, and `-` for delete. Nodes are identified by paths (dot-separated strings) or integer IDs.

#### Grammar Elements:

1. **Operations**:
   - `+` (Create): Add a new node or update an existing one.
    - followed by optional identification
    - then followed by optional key value pair(s)
   - `@` (Read): Retrieve data from a node.
    - followed by identification
    - then optional : key
   - `^` (Update): Modify attributes of a node.
    - followed by identification
    - then optional key value pair(s)
   - `-` (Delete): Remove a node or an attribute.
    - followed by identification
    - then followed

2. **Identification**:
    - can be a path or a integer id
   - Path: Dot-separated strings (`user.profile.address`) or a single name `user`.
   - Integer ID: Plain integers (`123`).

3. **Key-Value Pairs**:
   - Used in create and update operations.
   - Consist of a key followed by a colon (`:`) and a value.

4. **Value**:
   - Integer: Plain integer (`123`).
   - Float: Floating-point number (`123.45`).
   - String: Quoted or unquoted single word(not all numbers) (`"example"` or `example`).
   - Node reference: Referenced by `@` followed by an identification.
   - New node: key value pair(s) wrapped in {}. ex: `{key: value}`
   - List: Enclosed in square brackets, containing values separated by spaces. Lists cannot contain another list.

Got it! Let’s refine the examples to correctly utilize the key-value format where the node creation is treated as a value with a preceding key. Additionally, I'll show how unquoted single-word strings can be used as values:
```

Content for ./pubspec.yaml:
```yaml
name: shroom_lang
description: A sample command-line application.
version: 1.0.0
# repository: https://github.com/my_org/my_repo

environment:
  sdk: ^3.3.4

# Add regular dependencies here.
dependencies:
  # path: ^1.8.0
  petitparser: 
    path: packages/dart-petitparser
  shroom:
    path: ../shroom

dev_dependencies:
  lints: ^3.0.0
  test: ^1.24.0
```

Content for ./lib/shroom_lang.dart:
```dart
```

Content for ./lib/dsl_parser/sub_parsers/identifier.dart:
```dart
import 'package:petitparser/petitparser.dart';

Parser identifier() {
  // Parser for identifiers: starts with a letter and followed by zero or more word characters
  return (letter() & word().star()).flatten();
}
```

Content for ./lib/dsl_parser/sub_parsers/identification.dart:
```dart
import 'package:petitparser/petitparser.dart';
import 'identifier.dart';

// Define the parser for a path
Parser path() {
  return identifier().plusSeparated(char('.'));
}

// Define the parser for an integer identifier
Parser integerId() {
  return digit().plus().flatten();
}

// Define the parser for identification
Parser identification() {
  return (path() | integerId()).flatten();
}

Parser key() {
  return identifier().trim();
}```

Content for ./lib/dsl_parser/sub_parsers/sub_parsers.dart:
```dart
export 'basic_value.dart';
export 'identifier.dart';
export 'node_ref_value.dart';
export 'identification.dart';```

Content for ./lib/dsl_parser/sub_parsers/basic_value.dart:
```dart
  import 'package:petitparser/petitparser.dart';
  import 'package:shroom_lang/dsl_parser/sub_parsers/identifier.dart';

  Parser integer() {
    //print('integer');
    return digit().plus().flatten();
  }

  Parser float() {
    //print('float');
    return (digit().plus() & char('.') & digit().plus()).flatten();
  }

  Parser sTring() {
        return (char('"') & any().starLazy(char('"')) & char('"'))
        .flatten()
        .map((value) => {"type": "string", "value": value.substring(1, value.length - 1)}) // Remove the quotes
      | identifier().flatten().map((value) => {"type": "string", "value": value});
  }
  


```

Content for ./lib/dsl_parser/sub_parsers/node_ref_value.dart:
```dart

import 'package:petitparser/petitparser.dart';
import 'identification.dart';

Parser nodeReference() {
  //print('nodeReference');
  return char('@') & identification();
}```

Content for ./lib/dsl_parser/test.dart:
```dart
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
```

Content for ./lib/dsl_parser/dsl_parser.dart:
```dart
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
```

