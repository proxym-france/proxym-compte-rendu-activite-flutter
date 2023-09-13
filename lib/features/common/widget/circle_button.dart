/*
 * Copyright (c) 2023.
 * created by Sofien Touati
 * at: 08/09/2023, 09:51
 */

import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
  }) : isSmall = false;

  const CircleIconButton.small({
    super.key,
    required this.icon,
    this.onPressed,
  }) : isSmall = true;

  final IconData icon;
  final bool isSmall;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final buttonStyle = IconButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(56)),
      backgroundColor: colorScheme.primaryContainer,
      disabledBackgroundColor: colorScheme.surfaceVariant,
    );

    return isSmall
        ? IconButton(
            style: buttonStyle,
            onPressed: onPressed,
            icon: Icon(icon),
          )
        : SizedBox(
            width: 56,
            height: 56,
            child: IconButton(
              style: buttonStyle,
              onPressed: onPressed,
              icon: Icon(icon),
            ),
          );
  }
}
