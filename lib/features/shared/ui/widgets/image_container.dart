import 'package:flutter/material.dart';

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
              ? Padding(
                  padding: const EdgeInsets.only(left: 6, top: 6),
                  child: _RemoveImageButton(
                    onPressed: () => removeImageCallback!(image),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _RemoveImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _RemoveImageButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    const shape = CircleBorder();
    return Material(
      shape: shape,
      color: Colors.red,
      child: InkWell(
        customBorder: shape,
        onTap: onPressed,
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }
}
