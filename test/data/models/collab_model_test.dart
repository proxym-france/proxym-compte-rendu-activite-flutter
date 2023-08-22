import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mycra_timesheet_app/data/models/collab_model.dart';
import 'package:mycra_timesheet_app/data/models/role_model.dart';

void main() {
  final testCollab = CollabModel(name: 'test', lastName: 'lastName', email: 'email@email.com', role: RoleModel.collab);
  final testCollabWithoutLastName = CollabModel(name: 'test', lastName: '', email: 'email@email.com', role: RoleModel.collab);

  test('should be a subclass of Equatable', () async {
    expect(testCollab, isA<Equatable>());
  });

  group("fromGson", () {
    test('should return a valid model when the last name is not available', () async {
      final Map<String, dynamic> jsonMap = {"_name": 'test', "_lastName": 'lastName', '_email': 'email@email.com'};
      final result = CollabModel.fromJson(jsonMap);
      expect(result, testCollab);
    });
    test('should return a valid model when the last name is not available', () async {
      final Map<String, dynamic> jsonMap = {"_name": 'test', "_lastName": "", '_email': 'email@email.com'};
      final result = CollabModel.fromJson(jsonMap);
      expect(result, testCollabWithoutLastName);
    });
  });
  group("RawJson", () {
    test('FromRawJson', () async {
      String json = """{
        "_name": "test",
        "_lastName": "lastName",
        "_email": "email@email.com"
      }""";
      final result = CollabModel.fromRawJson(json);
      expect(result, testCollab);
    });
    test('ToRawJson', () async {
      String json = '{"_name":"test","_lastName":"lastName","_email":"email@email.com"}';
      final result = testCollab.toRawJson();
      expect(result, json);
    });
  });
  group("toGson", () {
    test('should return a valid model when the last name is not available', () async {
      final Map<String, dynamic> expected = {"_name": "test", "_lastName": "lastName", "_email": "email@email.com"};
      final result = testCollab.toJson();
      expect(result, expected);
    });
    test('should return a valid model when the last name is not available', () async {
      final Map<String, dynamic> expected = {"_name": 'test', "_lastName": '', '_email': 'email@email.com'};
      final result = testCollabWithoutLastName.toJson();
      expect(result, expected);
    });
  });
}
