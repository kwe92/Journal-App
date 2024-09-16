import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

typedef TransitionsBuilderCallback = Widget Function(BuildContext, Animation<double>, Animation<double>, Widget);

typedef PageBuilderCallback = Widget Function(BuildContext, Animation<double>, Animation<double>);

class CustomPageRouteBuilder<T> extends PageRouteBuilder<T> {
  CustomPageRouteBuilder({
    required super.pageBuilder,
    bool isVerticalTranslation = true,
    TransitionsBuilderCallback? transitionsBuilder,
    super.transitionDuration,
    super.reverseTransitionDuration,
    super.opaque,
    super.barrierDismissible,
    super.barrierColor,
    super.barrierLabel,
    super.maintainState,
    super.fullscreenDialog,
    super.allowSnapshotting,
  }) : super(transitionsBuilder: transitionsBuilder ?? _defaultTransitionsBuilder(isVerticalTranslation));

  /// Add a SharedAxisTransition animation between routes to reinforce their spatial or navigational relationship.
  factory CustomPageRouteBuilder.sharedAxisTransition(
          {required PageBuilderCallback pageBuilder,
          SharedAxisTransitionType transitionType = SharedAxisTransitionType.horizontal,
          Duration transitionDuration = const Duration(milliseconds: 500),
          reverseTransitionDuration = const Duration(milliseconds: 500)}) =>
      CustomPageRouteBuilder(
        transitionDuration: transitionDuration,
        reverseTransitionDuration: reverseTransitionDuration,
        pageBuilder: pageBuilder,
        transitionsBuilder: (context, primaryAnimation, secondaryAnimation, child) => SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType, // SharedAxisTransitionType determines what axis the animation transitions on
          child: child,
        ),
      );

  /// a higher order function returning a [TransitionsBuilderCallback]
  static TransitionsBuilderCallback _defaultTransitionsBuilder(bool isVerticalTranslation) =>
      (context, animation, secondaryAnimation, child) {
        // where the animation starts on screen
        final begin = isVerticalTranslation ? const Offset(0, 1) : const Offset(1, 0);

        // where the animation ends on screen
        const end = Offset.zero;

        // how the animation enters and exits into view
        const curve = Curves.easeIn;

        final curveBetween = CurveTween(curve: curve);

        final animateBetween = Tween(
          begin: begin,
          end: end,
        ).chain(curveBetween); // chain, combines tweens

        final Animation<Offset> offsetAnimation = animation.drive<Offset>(animateBetween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      };
}


//  PageRouteBuilder

//    - allows the user to customize route transition animations

//    - NOTE: Route is synonymous to: Page, Screen, or View

// Curve Class

//   - A collection of common animation curves that can alter how a Route enters into view
//    adjusting the rate of the animation over time

//   - i.e. does the Route (View / Screen) start fast and end slow (Curves.easeIn) or does it bounce into view (Curves.bounceIn)


// Offset.zero

//   - equivalent to OffSet(0,0) and represents the origin of 2-d Real Cartesian Coordinate Space (two dimensional grid system)

//   - the y-axis is inverted relative to the mathematical 2-D Cartesian Plane and increases in the downward direction


// SlideTransition

//   - creates a fractional translation (slide) on the Cartesian Plane