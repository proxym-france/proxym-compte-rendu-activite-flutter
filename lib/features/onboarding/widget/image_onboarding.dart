import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mycra_timesheet_app/features/onboarding/widget/onboarding_painter.dart';

class ImageOnboarding extends StatelessWidget {
  const ImageOnboarding({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipPath(
        clipper: ImagePainter(),
        child: CachedNetworkImage(
          height: size.height * .54,
          imageUrl: url,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) => const SizedBox(
            width: 850,
            height: 1200,
            child: Icon(Icons.image),
          ),
          errorWidget: (context, url, error) => const SizedBox(
            width: 850,
            height: 1200,
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
