import 'dart:convert';

class HolidayModel {
  final int id;
  final DateTime date;
  final String name;

  HolidayModel({
    required this.id,
    required this.date,
    required this.name,
  });

  HolidayModel copyWith({
    int? id,
    DateTime? date,
    String? name,
  }) =>
      HolidayModel(
        id: id ?? this.id,
        date: date ?? this.date,
        name: name ?? this.name,
      );

  factory HolidayModel.fromRawJson(String str) =>
      HolidayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HolidayModel.fromJson(Map<String, dynamic> json) => HolidayModel(
        id: json["_id"],
        date: DateTime.parse(json["_date"]),
        name: json["_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "_date": date.toIso8601String(),
        "_name": name,
      };
}
