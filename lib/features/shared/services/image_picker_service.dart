import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:journal_app/features/shared/models/photo.dart';

/// Responsible for:
/// - picking images from a users gallery
/// - converting XFile's to ImageProvider's
/// - Converting images to and from String's

class ImagePickerService {
  Future<(List<XFile> imageFiles, String error)> pickImages() async {
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;

    try {
      final List<XFile> pickedImageFile = await picker.getMultiImageWithOptions(
        // TODO: review image options
        options: const MultiImagePickerOptions(
          imageOptions: ImageOptions(
            imageQuality: 50,
            maxWidth: 150,
          ),
        ),
      );

      if (pickedImageFile.isEmpty) {
        return (<XFile>[], '');
      }

      return (pickedImageFile, '');
    } catch (error) {
      return (<XFile>[], error.toString());
    }
  }

  List<ImageProvider> toImageProvider(List<XFile> imageFiles) {
    final imageProviders = [for (var imageFile in imageFiles) FileImage(File(imageFile.path))];
    return imageProviders;
  }

  Future<List<String>> convertToString(List<XFile> imageFiles) async {
    final images = [for (var imageFile in imageFiles) base64Encode(await imageFile.readAsBytes())];

    return images;
  }

  List<ImageProvider> imageFromBase64String(List<Photo?> imageObjs) {
    final images = [
      for (Photo? photo in imageObjs)
        Image.memory(
          base64Decode(photo!.imageName),
          fit: BoxFit.fill,
        ).image
    ];

    return images;
  }

  Map<String, ImageProvider> imageFromBase64StringAsMap(List<Photo?> imageObjs) {
    Map<String, ImageProvider> result = {};

    debugPrint("imageFromBase64StringAsMap imageObjs count: ${imageObjs.length}");

    for (var i = 0; i < imageObjs.length; i++) {
      result.addAll(
        {
          '${imageObjs[i]!.imageName}-$i': Image.memory(
            base64Decode(imageObjs[i]!.imageName),
            // TODO: review
            fit: BoxFit.fill,
          ).image,
        },
      );
    }

    return result;
  }
}
