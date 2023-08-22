import 'dart:convert';

class AbsenceModel {
  final bool matin;
  final DateTime date;
  final String raison;

  AbsenceModel({
    required this.matin,
    required this.date,
    required this.raison,
  });

  AbsenceModel copyWith({
    bool? matin,
    DateTime? date,
    String? raison,
  }) =>
      AbsenceModel(
        matin: matin ?? this.matin,
        date: date ?? this.date,
        raison: raison ?? this.raison,
      );

  factory AbsenceModel.fromRawJson(String str) =>
      AbsenceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AbsenceModel.fromJson(Map<String, dynamic> json) => AbsenceModel(
        matin: json["matin"],
        date: DateTime.parse(json["date"]),
        raison: json["raison"],
      );

  Map<String, dynamic> toJson() => {
        "matin": matin,
        "date": date.toIso8601String(),
        "raison": raison,
      };
}
