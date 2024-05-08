import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';

class ImageContainer extends StatelessWidget {
  final ImageProvider image;
  final void Function(ImageProvider image)? removeImageCallback;

  const ImageContainer({
    required this.image,
    this.removeImageCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge, // force child to take the shape of parent container
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: image,
              ),
            ),
          ),
          removeImageCallback != null
              ? IconButton(
                  onPressed: () => removeImageCallback!(image),
                  icon: const Icon(
                    Icons.close,
                    size: 26,
                    weight: 600,
                    color: AppColors.mainThemeColor,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
