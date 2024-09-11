import 'dart:math';

import 'package:flutter/material.dart';

/// Responsible for animating and positioning an individual ActionButton widget.
@immutable
class ExpandingActionButton extends StatelessWidget {
  final double directionInDegrees;

  final double maxDistance;

  final Animation<double> progress;

  final Widget child;

  const ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (BuildContext context, Widget? child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (pi / 180.0),
          progress.value * maxDistance,
        );

        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

// Fly out, Fly back Motion

//   - requires explicit (x,y) positioning of each Widget and an Animation to choreograph changes to those (x,y) positions over time.