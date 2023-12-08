import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

/// a PortalTarget with a [DismissibleBarrier] that closes the follower attached to the target if the user clicks outside of the follower.
class CustomPortalTarget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isVisible;
  final Anchor anchor;
  final Widget follower;
  final Widget target;

  const CustomPortalTarget({
    required this.onPressed,
    required this.isVisible,
    required this.anchor,
    required this.follower,
    required this.target,
    super.key,
  });

  @override
  Widget build(BuildContext context) => DismissibleBarrier(
        onPressed: onPressed,
        isVisible: isVisible,
        target: PortalTarget(
          // TODO: add animation | maybe have two option one for animated and one for static via boolean selection
          // closeDuration: kThemeAnimationDuration,
          visible: isVisible,
          anchor: anchor,
          portalFollower: follower,
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
