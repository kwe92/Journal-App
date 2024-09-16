import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class OpenContainerWrapper extends StatelessWidget {
  final Widget closedChild;
  final Widget openChild;
  final Duration duration;
  final ContainerTransitionType transitionType;
  final ShapeBorder closedShape;
  final double openElevation;
  final double closedElevation;
  final Color? middleColor;
  final Color? openColor;
  final Color? closedColor;

  const OpenContainerWrapper({
    required this.closedChild,
    required this.openChild,
    this.middleColor,
    this.openColor,
    this.closedColor,
    this.openElevation = 4,
    this.closedElevation = 0,
    Duration? duration,
    ContainerTransitionType? transitionType,
    ShapeBorder? closedShape,
    super.key,
  })  : duration = duration ?? const Duration(milliseconds: 800),
        transitionType = transitionType ?? ContainerTransitionType.fadeThrough,
        closedShape = closedShape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OpenContainer(
      middleColor: middleColor,
      transitionType: transitionType,
      transitionDuration: duration,
      openBuilder: (context, closedContainer) => openChild,
      openColor: openColor ?? theme.colorScheme.background,
      openElevation: openElevation,
      closedShape: closedShape,
      closedElevation: closedElevation,
      closedColor: closedColor ?? theme.colorScheme.background,
      closedBuilder: (context, openContainer) => InkWell(
        onTap: openContainer.call, // closedBuilder should call the function that is passed in as an argument to open the container
        child: closedChild,
      ),
    );
  }
}
