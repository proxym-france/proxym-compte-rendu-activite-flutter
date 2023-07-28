import 'dart:convert';

import 'package:equatable/equatable.dart';

class CollabModel extends Equatable {
  final String name;
  final String email;

  CollabModel({
    required this.name,
    required this.email,
  });

  factory CollabModel.fromRawJson(String str) =>
      CollabModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CollabModel.fromJson(Map<String, dynamic> json) => CollabModel(
        name: json["_name"],
        email: json["_email"],
      );

  Map<String, dynamic> toJson() => {
        "_name": name,
        "_email": email,
      };

  @override
  List<Object?> get props => [name, email];
}
