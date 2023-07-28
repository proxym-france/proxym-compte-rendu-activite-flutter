import 'package:flutter/cupertino.dart';

class ImagePainter extends CustomClipper<Path> {
  ImagePainter({this.widgetSize});

  final Size? widgetSize;

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 850;
    final double yScaling = size.height / 1201;
    path.lineTo(3.49999 * xScaling, 50.5 * yScaling);
    path.cubicTo(
      10.3 * xScaling,
      12.9 * yScaling,
      46.6667 * xScaling,
      1.5 * yScaling,
      64 * xScaling,
      0.5 * yScaling,
    );
    path.cubicTo(
      64 * xScaling,
      0.5 * yScaling,
      244 * xScaling,
      0 * yScaling,
      244 * xScaling,
      0 * yScaling,
    );
    path.cubicTo(
      262.8 * xScaling,
      1.6 * yScaling,
      274.5 * xScaling,
      13 * yScaling,
      281 * xScaling,
      30 * yScaling,
    );
    path.cubicTo(
      287.5 * xScaling,
      47 * yScaling,
      281 * xScaling,
      91.5 * yScaling,
      331 * xScaling,
      99 * yScaling,
    );
    path.cubicTo(
      331 * xScaling,
      99 * yScaling,
      775 * xScaling,
      99 * yScaling,
      775 * xScaling,
      99 * yScaling,
    );
    path.cubicTo(
      831.4 * xScaling,
      95.4 * yScaling,
      848.167 * xScaling,
      140.833 * yScaling,
      849.5 * xScaling,
      164 * yScaling,
    );
    path.cubicTo(
      849.5 * xScaling,
      164 * yScaling,
      849.5 * xScaling,
      1126 * yScaling,
      849.5 * xScaling,
      1126 * yScaling,
    );
    path.cubicTo(
      851.5 * xScaling,
      1187.6 * yScaling,
      803 * xScaling,
      1201.33 * yScaling,
      778.5 * xScaling,
      1200.5 * yScaling,
    );
    path.cubicTo(
      778.5 * xScaling,
      1200.5 * yScaling,
      346.5 * xScaling,
      1200.5 * yScaling,
      346.5 * xScaling,
      1200.5 * yScaling,
    );
    path.cubicTo(
      303.3 * xScaling,
      1196.5 * yScaling,
      286.833 * xScaling,
      1159.17 * yScaling,
      284 * xScaling,
      1141 * yScaling,
    );
    path.cubicTo(
      284 * xScaling,
      1141 * yScaling,
      284 * xScaling,
      1077 * yScaling,
      284 * xScaling,
      1077 * yScaling,
    );
    path.cubicTo(
      285.6 * xScaling,
      1028.2 * yScaling,
      247 * xScaling,
      1010 * yScaling,
      227.5 * xScaling,
      1007 * yScaling,
    );
    path.cubicTo(
      227.5 * xScaling,
      1007 * yScaling,
      84.5 * xScaling,
      1007 * yScaling,
      84.5 * xScaling,
      1007 * yScaling,
    );
    path.cubicTo(
      16.9 * xScaling,
      1013.4 * yScaling,
      0.333323 * xScaling,
      961.667 * yScaling,
      0.49999 * xScaling,
      935 * yScaling,
    );
    path.cubicTo(
      0.49999 * xScaling,
      935 * yScaling,
      3.49999 * xScaling,
      50.5 * yScaling,
      3.49999 * xScaling,
      50.5 * yScaling,
    );
    path.cubicTo(
      3.49999 * xScaling,
      50.5 * yScaling,
      3.49999 * xScaling,
      50.5 * yScaling,
      3.49999 * xScaling,
      50.5 * yScaling,
    );
    return path;
  }
}
