import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/ui/widgets/image_container.dart';

class ImageRow extends StatelessWidget {
  final void Function(ImageProvider image)? removeImageCallback;

  final List<ImageProvider> images;

  final double height;

  const ImageRow({
    required this.images,
    this.removeImageCallback,
    this.height = 150,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: images.length == 2
          ? Row(
              children: [
                ImageContainer(removeImageCallback: removeImageCallback, image: images[0]),
                const SizedBox(width: 6),
                ImageContainer(removeImageCallback: removeImageCallback, image: images[1]),
              ],
            )
          : Row(
              children: [
                ImageContainer(removeImageCallback: removeImageCallback, image: images[0]),
                const SizedBox(width: 6),
                ImageContainer(removeImageCallback: removeImageCallback, image: images[1]),
                const SizedBox(width: 6),
                ImageContainer(removeImageCallback: removeImageCallback, image: images[2]),
              ],
            ),
    );
  }
}
