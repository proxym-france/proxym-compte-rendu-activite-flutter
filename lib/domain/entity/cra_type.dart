import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/core/theme/colors.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';

enum CraType {
  project('Projet', AppColors.blue30C9C6),
  formation('Formation', AppColors.blue30C9C6),
  paidLeave('Conges', AppColors.pinkF06B96),
  unpaidLeave('Conges sans solde', AppColors.pinkF06B96),
  rTT('RTT', AppColors.pinkF06B96),
  sickLeave('Maladie', AppColors.pinkF06B96),
  exceptional('Exceptionnelle', AppColors.pinkF06B96),
  holiday('holiday', AppColors.orangeD38430),
  blank('Available', AppColors.greyD38430);

  const CraType(this.value, this.color);

  static CraType getByValue(String value) {
    return CraType.values.firstWhere((element) => element.value == value);
  }

  static List<Project> mapToProject() {
    return CraType.values
        .where((element) => element.color == AppColors.pinkF06B96)
        .map((e) => Project(code: e.value, name: e.value, client: 'Proxym', craType: e))
        .toList();
  }

  final Color color;
  final String value;
}
