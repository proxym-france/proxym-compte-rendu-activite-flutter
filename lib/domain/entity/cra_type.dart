import 'package:flutter/material.dart';

enum CraType {
  project('Projet', Color(0xFF82B04A)),
  formation('Formation', Color(0xFF82B04A)),
  paidLeave('Conges', Color(0xFFC13926)),
  unpaidLeave('Conges sans solde', Color(0xFFC13926)),
  rTT('RTT', Color(0xFFC13926)),
  sickLeave('Maladie', Color(0xFFC13926)),
  exceptional('Exceptionnelle', Color(0xFFC13926)),
  holiday('holiday', Color(0xffD38430));

  const CraType(this.value, this.color);

  static CraType getByValue(String value) {
    return CraType.values.firstWhere((element) => element.value == value);
  }

  final Color color;
  final String value;
}
