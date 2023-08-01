import 'package:flutter_test/flutter_test.dart';
import 'package:mycra_timesheet_app/core/utils/name_parse.dart';

void main() {
  test('short name is empty', () {
    String input = '';
    var result = input.shortName();
    expect(result, '');
  });
  test('short name is blank', () {
    String input = ' ';
    var result = input.shortName();
    expect(result, '');
  });
  test('split name has one word', () {
    String input = 'test';
    var result = input.shortName();
    expect(result, 'T');
  });

  test('split name has first and last', () {
    String input = "test test";
    var result = input.shortName();
    expect(result,'TT');
  });
  test('split name has first middle and last', () {
    String input = "test ben test";
    var result = input.shortName();
    expect(result,'TBT');
  });
  test('split name has first middle and complex last', () {
    String input = "test tested ben test ";
    var result = input.shortName();
    expect(result, 'TTBT');
  });
}
