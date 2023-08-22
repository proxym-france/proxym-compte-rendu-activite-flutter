import 'package:flutter/material.dart';

class ShortNameCircleAvatar extends StatelessWidget {
  const ShortNameCircleAvatar({
    super.key,
    required this.color,
    required this.shortName,
    this.radius,
  });

  final double? radius;
  final Color color;
  final String shortName;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var backgroundColor = color;
    var textColor = backgroundColor.computeLuminance() > .5 ? Colors.black : Colors.white;

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        shortName,
        style: textTheme.titleSmall?.copyWith(color: textColor),
      ),
    );
  }
}
