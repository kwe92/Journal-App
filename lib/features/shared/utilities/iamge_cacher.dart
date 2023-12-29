import 'package:flutter/material.dart';

// Resources

//     - https://www.youtube.com/watch?v=M43XWGV3TE8
//     - https://stackoverflow.com/questions/63280292/how-to-properly-precache-images-for-stateless-widgets
//     - https://api.flutter.dev/flutter/widgets/precacheImage.html

/// Pre-caches images to avoid flashing.
class ImageCacher {
  /// Caches images that are not SVG's to avoid flashing when images load for the first time
  static Future<void> cacheAssetImage(BuildContext context, ImageProvider assetImage) async {
    await precacheImage(assetImage, context);
  }
}
