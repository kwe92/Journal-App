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
    // default parameters should always be initialized in the condtructor
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
          // closeDuration, animate out as well as in
          closeDuration: isAnimated && animateOnClose ? animationDuration : null,
          visible: isVisible,
          anchor: anchor,
          portalFollower: isAnimated
              ?
              // the parameterized type T passed to TweenAnimationBuilder<T> represents the type for the value/progress parameter of the builder callback
              TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: isVisible ? 1 : 0),
                  duration: animationDuration,
                  builder: (BuildContext context, double progress, _) {
                    return Transform(
                      // determines dynamic translation of widget, screen acts as cartesian plane (i.e. how the widget slides on the screen on the x and y axis)
                      transform: animationType == 0
                          ?
                          // slide in the vertical direction y axis
                          Matrix4.translationValues(0, (1 - progress) * translationStartDistance, 0)
                          :
                          // slide in the horizontal direction x axis
                          Matrix4.translationValues((1 - progress) * translationStartDistance, 0, 0),
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

/// Transparent barrier surounding a target.
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

// TweenAnimationBuilder

//    - build custom animations without an AnimationController
//    - important properties:
//        - TweenAnimationBuilder<T>: T represents the type of value you want to animate with
//        - tween: the range of values that you want to animate be-tween
//        - duration: duration of the animation
//        - builder: widget you wish to animate
//        - onEnd: a callback triggered at the end of the animation | can also be use to set and new value and animate again
//        - child: allows flutter to not rebuild the entire widget tree during animation for optimization purposes

// Tween

//   - stands for `be-tween`, represents the animation values to range over from beginning to end
//   - start and end values of the TweenAnimationBuilder builder property callback

// Curve

//   - modifies the way you animate between one value and another