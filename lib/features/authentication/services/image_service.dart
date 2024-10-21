import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/utilities/iamge_cacher.dart';
import 'package:journal_app/features/shared/utilities/random_number_generator.dart';
import 'package:stacked/stacked.dart';

/// provides random images used throughout the application.
class ImageService with ListenableServiceMixin {
  ImageProvider mindful01 = Image.asset("assets/images/mindful01.avif").image;

  ImageProvider mindful02 = Image.asset("assets/images/mindful02.avif").image;

  ImageProvider mindful03 = Image.asset("assets/images/mindful03.avif").image;

  String _previouslyChosenFriend = '';

  final _meditatingFriends = [
    'assets/lottie/calming-monkey.json',
    'assets/lottie/centered-bull.json',
    'assets/lottie/mindful-fox.json',
    'assets/lottie/peacfully-slothful.json',
  ];

  /// Cache [ImageProvider] to avoid flashing when images load for the first time.
  Future<void> cacheImage(BuildContext context) async {
    final mindfulImages = [
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
    final mindfulImages = [
      mindful01,
      mindful02,
      mindful03,
    ];

    final index = RandomNumberGenerator.randIntRange(max: mindfulImages.length);

    return mindfulImages[index];
  }

  String getRandomMeditatingFriend() {
    //!! TODO: rerun app and rework implementation
    final meditatingFriends = [..._meditatingFriends];

    meditatingFriends.remove(_previouslyChosenFriend);

    final count = meditatingFriends.length;

    final randomFriend = meditatingFriends[RandomNumberGenerator.randIntRange(max: count)];

    _previouslyChosenFriend = randomFriend;

    return randomFriend;
  }
}
