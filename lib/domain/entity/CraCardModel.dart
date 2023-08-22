import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';

class CraCardModel extends Equatable {
  final String title;
  final CraType type;
  DateTimeRange range;

  CraCardModel({required this.title, required this.type, required this.range});

  void extendRange(int days) {
    range = DateTimeRange(start: range.start, end: range.end.add(Duration(days: days)));
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
