import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/features/common/widget/circle_button.dart';

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({
    super.key,
    this.leading,
    required this.title,
    required this.trailingIcon,
    this.onTap,
    this.onTrailingTap,
    this.mainAxisSize = MainAxisSize.max,
  }) : isSmall = false;

  const SelectorWidget.small({
    super.key,
    this.leading,
    required this.title,
    required this.trailingIcon,
    this.onTap,
    this.onTrailingTap,
    this.mainAxisSize = MainAxisSize.min,
  }) : isSmall = true;
  final MainAxisSize mainAxisSize;
  final bool isSmall;
  final Widget? leading;
  final Widget title;
  final IconData trailingIcon;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leading != null) leading!,
            Padding(
              padding: EdgeInsets.only(left: leading == null ? 24.0 : 0),
              child: title,
            ),
            isSmall
                ? CircleIconButton.small(icon: trailingIcon, onPressed: onTrailingTap)
                : CircleIconButton(icon: trailingIcon, onPressed: onTrailingTap),
          ],
        ),
      ),
    );
  }
}
