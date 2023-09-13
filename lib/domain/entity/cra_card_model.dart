/*
 * Copyright (c) 2023.
 * created by Sofien Touati
 * at: 01/09/2023, 11:32
 */

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_type.dart';

class CraCardModel extends Equatable {
  final String title;
  final CraType type;
  final int percentage;
  final DateTimeRange range;

  factory CraCardModel.fromCra(Cra cra) =>
      CraCardModel(title: cra.title, type: cra.type, percentage: cra.percentage, range: DateTimeRange(start: cra.date, end: cra.date));

  static List<CraCardModel> mapToCraCardModel(List<List<Cra>> cras) {
    final List<CraCardModel> result = [];
    cras.forEachIndexed(
      (index, element) {
        if (result.isEmpty || element.length > 1) {
          result.addAll(element.map((e) => CraCardModel.fromCra(e)));
        } else {
          var last = result.last;
          if (last.title == element[0].title && last.percentage == 100 && element[0].date.difference(last.range.end).inDays == 1) {
            result.last = last.extendRange(1);
          } else {
            result.add(CraCardModel.fromCra(element[0]));
          }
        }
      },
    );
    return result;
  }

  CraCardModel extendRange(int days) {
    return copyWith(range: DateTimeRange(start: range.start, end: range.end.add(Duration(days: days))));
  }

  @override
  List<Object?> get props => [title, type, range];

  const CraCardModel({
    required this.title,
    required this.type,
    required this.range,
    required this.percentage,
  });

  CraCardModel copyWith({String? title, CraType? type, DateTimeRange? range, int? percentage}) {
    return CraCardModel(title: title ?? this.title, type: type ?? this.type, range: range ?? this.range, percentage: percentage ?? this.percentage);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "type": type,
      "percentage": percentage,
      "range": range,
    };
  }
}
