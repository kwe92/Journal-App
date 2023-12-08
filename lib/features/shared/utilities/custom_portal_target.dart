import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

/// a PortalTarget with [DismissibleBarrier] to close follower attached to target if user clicks outside the follower.
///
/// Can also enable animations.
class CustomPortalTarget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isVisible;
  final Anchor anchor;
  final Widget follower;
  final Widget target;
  final bool isAnimated;
  final Duration animationDuration;
  final double translationStartDistance;

  /// determines animation on close.
  final bool animateOnClose;

  /// 0 to anime vertically, 1 to animate horizontally.
  final int animationType;

  const CustomPortalTarget({
    required this.onPressed,
    required this.isVisible,
    required this.anchor,
    required this.follower,
    required this.target,
    this.isAnimated = false,
    this.animationDuration = kThemeAnimationDuration,
    this.animationType = 0,
    this.translationStartDistance = 200,
    this.animateOnClose = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => DismissibleBarrier(
        onPressed: onPressed,
        isVisible: isVisible,
        target: PortalTarget(
          // add closeDuration if you want to animate out as well as in
          closeDuration: isAnimated && animateOnClose ? animationDuration : null,
          visible: isVisible,
          anchor: anchor,
          portalFollower: isAnimated
              ? TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: isVisible ? 1 : 0),
                  duration: animationDuration,
                  // renamed value argument to progress and used placeholder underscore for child property as it will not be used
                  builder: (context, progress, _) {
                    return Transform(
                      // determines the translation of a widget dynamically were the screen acts as the cartesian plane (i.e. how the widget slides on the screen)
                      transform: animationType == 0
                          ? Matrix4.translationValues(0, (1 - progress) * translationStartDistance, 0)
                          : Matrix4.translationValues((1 - progress) * translationStartDistance, 0, 0),
                      child: Opacity(
                        opacity: progress,
                        child: follower,
                      ),
                    );
                  },
                )
              : follower,
          child: target,
        ),
      );
}

/// invisible barrier surounding a target.
///
/// Dismisses the attached follower of the target if a user clicks outside of the follower.
class DismissibleBarrier extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isVisible;
  final Widget target;

  const DismissibleBarrier({
    required this.onPressed,
    required this.isVisible,
    required this.target,
    super.key,
  });

  @override
  Widget build(BuildContext context) => PortalTarget(
        visible: isVisible,
        portalFollower: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onPressed,
          // can add child to color and animate the dismissible barrier
          // child: ,
        ),
        child: target,
      );
}
