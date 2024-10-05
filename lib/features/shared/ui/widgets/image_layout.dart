import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/ui/widgets/image_container.dart';
import 'package:journal_app/features/shared/ui/widgets/image_row.dart';

class ImageLayout extends StatelessWidget {
  final void Function(ImageProvider image)? removeImageCallback;

  final List<ImageProvider> images;

  const ImageLayout({
    required this.images,
    this.removeImageCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("ImageLayout images.length: ${images.length}");
    return images.length == 1
        ? SizedBox(
            height: 180,
            child: Column(
              children: [
                ImageContainer(
                  removeImageCallback: removeImageCallback,
                  image: images[0],
                ),
              ],
            ),
          )
        : images.length == 2
            ? ImageRow(
                images: [images[0], images[1]],
                height: 180,
                removeImageCallback: removeImageCallback,
              )
            : images.length == 3
                ? ImageRow(
                    images: [images[0], images[1], images[2]],
                    height: 180,
                    removeImageCallback: removeImageCallback,
                  )
                : images.length == 4
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageRow(
                            images: [images[0], images[1]],
                            removeImageCallback: removeImageCallback,
                          ),
                          const SizedBox(height: 6),
                          ImageRow(
                            images: [images[2], images[3]],
                            removeImageCallback: removeImageCallback,
                          ),
                        ],
                      )
                    : images.length == 5
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ImageRow(
                                images: [images[0], images[1]],
                                removeImageCallback: removeImageCallback,
                              ),
                              const SizedBox(height: 6),
                              ImageRow(
                                images: [images[2], images[3], images[4]],
                                removeImageCallback: removeImageCallback,
                              ),
                            ],
                          )
                        : images.length == 6
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ImageRow(
                                    images: [images[0], images[1], images[2]],
                                    removeImageCallback: removeImageCallback,
                                  ),
                                  const SizedBox(height: 6),
                                  ImageRow(
                                    images: [images[3], images[4], images[5]],
                                    removeImageCallback: removeImageCallback,
                                  ),
                                ],
                              )
                            : images.length == 7
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ImageRow(
                                        images: [images[0], images[1]],
                                        removeImageCallback: removeImageCallback,
                                      ),
                                      const SizedBox(height: 6, width: 6),
                                      ImageRow(
                                        images: [images[2], images[3]],
                                        removeImageCallback: removeImageCallback,
                                      ),
                                      const SizedBox(height: 6, width: 6),
                                      ImageRow(
                                        images: [images[4], images[5], images[6]],
                                        removeImageCallback: removeImageCallback,
                                      ),
                                    ],
                                  )
                                : images.length == 8
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ImageRow(
                                            images: [images[0], images[1]],
                                            removeImageCallback: removeImageCallback,
                                          ),
                                          const SizedBox(height: 6, width: 6),
                                          ImageRow(
                                            images: [images[2], images[3], images[4]],
                                            removeImageCallback: removeImageCallback,
                                          ),
                                          const SizedBox(height: 6),
                                          ImageRow(
                                            images: [images[5], images[6], images[7]],
                                            removeImageCallback: removeImageCallback,
                                          ),
                                        ],
                                      )
                                    : images.length == 9
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ImageRow(
                                                images: [images[0], images[1], images[2]],
                                                removeImageCallback: removeImageCallback,
                                              ),
                                              const SizedBox(height: 6),
                                              ImageRow(
                                                images: [images[3], images[4], images[5]],
                                                removeImageCallback: removeImageCallback,
                                              ),
                                              const SizedBox(height: 6),
                                              ImageRow(
                                                images: [images[6], images[7], images[8]],
                                                removeImageCallback: removeImageCallback,
                                              ),
                                            ],
                                          )
                                        : const SizedBox();
  }
}
