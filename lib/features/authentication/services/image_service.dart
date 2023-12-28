import 'dart:math';

/// provides random images used throughout the application
class ImageService {
  final List<String> _mindfulImages = [
    "assets/images/mindful01.avif",
    "assets/images/mindful02.avif",
    "assets/images/mindful03.avif",
  ];

  static final _rand = Random();

  String getRandomMindfulImage() {
    final index = _rand.nextInt(_mindfulImages.length);
    return _mindfulImages[index];
  }
}
