/*
 * Copyright (c) 2023.
 * created by Sofien Touati
 * at: 05/09/2023, 16:32
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycra_timesheet_app/features/common/widget/circle_button.dart';
import 'package:mycra_timesheet_app/features/common/widget/selector.dart';

class ValuePickerWidget extends StatefulWidget {
  final double initialValue;
  final double multiplier;
  final ValueChanged<double>? onValueChanged;

  final double maxValue;

  const ValuePickerWidget({
    super.key,
    double? initialValue,
    this.onValueChanged,
    required this.maxValue,
    double? multiplier,
  })  : multiplier = multiplier ?? 1,
        initialValue = initialValue ?? 0;

  @override
  State<ValuePickerWidget> createState() => _ValuePickerWidgetState();
}

class _ValuePickerWidgetState extends State<ValuePickerWidget> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = (widget.initialValue / widget.multiplier).floor();
  }

  @override
  Widget build(BuildContext context) {
    return SelectorWidget.small(
      leading: CircleIconButton.small(
        icon: Icons.chevron_left,
        onPressed: (value > 0)
            ? () {
                setState(() {
                  value -= 1;
                  widget.onValueChanged?.call(value * widget.multiplier);
                });
              }
            : null,
      ),
      title: Text('${NumberFormat('###.##').format(value * widget.multiplier)}%'),
      trailingIcon: Icons.chevron_right,
      onTrailingTap: ((value + 1) * widget.multiplier <= widget.maxValue)
          ? () {
              setState(() {
                value += 1;
                widget.onValueChanged?.call(value * widget.multiplier);
              });
            }
          : null,
    );
  }
}
