import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';

class CraCardModel extends Equatable {
  final String title;
  final CraType type;
  DateTimeRange range;

  CraCardModel({required this.title, required this.type, required this.range});

  factory CraCardModel.fromCra(Cra cra) => CraCardModel(title: cra.title, type: cra.type, range: DateTimeRange(start: cra.date, end: cra.date));

  static List<CraCardModel> mapToCraCardModel(Set<Cra> cras) {
    final List<CraCardModel> result = [];
    cras.sortedBy((element) => element.date).forEachIndexed(
      (index, element) {
        if (result.isEmpty) {
          result.add(CraCardModel.fromCra(element));
        } else {
          var last = result.last;
          if (last.title == element.title && element.date.difference(last.range.end).inDays == 1) {
            last.extendRange(1);
          } else {
            result.add(CraCardModel.fromCra(element));
          }
        }
      },
    );
    return result;
  }

  void extendRange(int days) {
    range = DateTimeRange(start: range.start, end: range.end.add(Duration(days: days)));
  }

  @override
  List<Object?> get props => [title, type, range];
}
