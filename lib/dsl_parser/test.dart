import 'dart:convert'; // Import Dart's convert library to use jsonEncode

import 'package:petitparser/petitparser.dart';

import 'dsl_parser.dart'; // Correct import path if necessary

void main() {
  // Create an instance of your DSLParserDefinition
  final parser = DSLParserDefinition().build();

  // Define a list of test strings to parse
  List<String> tests = [
    // Adding various types of operations with nested attributes and list handling
    '+id123 profile:{address:{city:NewYork state:NY}}',
    '+id123 name:John age:25 status:active friends:[@idstr @123 @sajo] year:2021',
    '@id123:name',
    '^id123 profile:{name:Jane} friends:[@idstr @123]',
    '-id123',

    // Adding a variety of complex nested objects and multiple operations in one input
    '+user1 name:John friends:[@user2 @user3] address:{city:LA state:CA}',
    '@user1:friends',
    '^user1 address:{city:San Francisco} friends:[@user5]',
    '-user1:friends',

    // Testing error handling for duplicate keys and improper formats
    '+id123 name:John age:30 age:31', // Duplicate key should cause an error
    '+id123 name:John friends:[{name:Alex age:30} {name:Alex age:30}]', // Test nested object parsing
    '-id123', // Simple delete operation
    '@id123', // Simple read operation
    '^id123 name:null' // Test edge cases for values
  ];

  // Parse each string and print the results
  for (var test in tests) {
    try {
      final result = parser.parse(test);
      if (result is Success) {
        print('Parsing success: $test');
        for (var value in result.value) {
          print('Result: ${JsonEncoder.withIndent('  ').convert(value)}');
        }
        // print('Result: ${JsonEncoder(result.value)}');
      } else {
        print('Parsing failed: $test');
        print('Error: ${result.message} at position ${result.position}');
      }
    } catch (e) {
      print('Parsing failed: $test');
      print('Error: $e');
    }
  }
}
