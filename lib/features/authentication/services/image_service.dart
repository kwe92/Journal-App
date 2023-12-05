import 'dart:math';

class ImageService {
  static final List<String> mindfulImages = [
    "assets/images/mindful01.avif",
    "assets/images/mindful02.avif",
    "assets/images/mindful03.avif"
  ];

  static final _rand = Random();

  String getRandomMindfulImage() {
    final index = _rand.nextInt(mindfulImages.length);
    return mindfulImages[index];
  }
}
