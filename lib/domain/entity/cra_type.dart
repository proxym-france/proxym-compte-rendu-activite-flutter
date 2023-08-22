import 'package:flutter/material.dart';

enum CraType {
  project('Projet', Color(0xFF82B04A)),
  formation('Formation', Color(0xFF82B04A)),
  paidLeave('Conges', Colors.redAccent),
  unpaidLeave('Conges sans solde', Colors.redAccent),
  rTT('RTT', Colors.redAccent),
  sickLeave('Maladie', Colors.redAccent),
  exceptional('Exceptionnelle', Colors.redAccent),
  holiday('holiday', Color(0xffD38430));

  const CraType(this.value, this.color);

  static CraType getByValue(String value) {
    return CraType.values.firstWhere((element) => element.value == value);
  }

  final Color color;
  final String value;
}
