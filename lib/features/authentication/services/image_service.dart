import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/utilities/iamge_cacher.dart';
import 'package:journal_app/features/shared/utilities/random_number_generator.dart';
import 'package:stacked/stacked.dart';

/// provides random images used throughout the application.
class ImageService with ListenableServiceMixin {
  ImageProvider mindful01 = Image.asset("assets/images/mindful01.avif").image;

  ImageProvider mindful02 = Image.asset("assets/images/mindful02.avif").image;

  ImageProvider mindful03 = Image.asset("assets/images/mindful03.avif").image;

  /// Cache [ImageProvider] to avoid flashing when images load for the first time.
  Future<void> cacheImage(BuildContext context) async {
    final List<ImageProvider> mindfulImages = [
      mindful01,
      mindful02,
      mindful03,
    ];

    for (int i = 0; i < mindfulImages.length; i++) {
      await ImageCacher.cacheAssetImage(context, mindfulImages[i]);
    }

    notifyListeners();
  }

  ImageProvider getRandomMindfulImage() {
    final List<ImageProvider> mindfulImages = [
      mindful01,
      mindful02,
      mindful03,
    ];

    final index = RandomNumberGenerator.randIntRange(max: mindfulImages.length);

    return mindfulImages[index];
  }
}
