
import 'package:petitparser/petitparser.dart';
import 'identification.dart';

Parser nodeReference() {
  //print('nodeReference');
  return char('@') & identification();
}