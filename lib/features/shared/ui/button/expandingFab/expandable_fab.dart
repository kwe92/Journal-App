import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/close_expanding_fab.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/controllers/expandable_fab_controller.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/expanding_action_button.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/open_expanding_fab.dart';
import 'package:provider/provider.dart';

//!! TODO: Add comments on what this widget is for | stacks button together

@immutable
class ExpandableFab extends StatelessWidget {
  final double distance;

  final List<Widget> children;

  final Color? backgroundColor;

  final bool? initialOpen;

  final double? angleInDegrees;

  final double? step;

  const ExpandableFab({
    required this.distance,
    required this.children,
    this.backgroundColor,
    this.initialOpen,
    this.angleInDegrees,
    this.step,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final controller = context.watch<ExpandableFabController>();
        return SizedBox.expand(
          child: GestureDetector(
            behavior: controller.open ? HitTestBehavior.translucent : null,
            onTap: controller.open ? controller.toggle : null,
            child: Stack(
              alignment: Alignment.bottomRight,
              clipBehavior: Clip.none,
              children: [
                CloseExpandingFab(
                  backgroundColor: backgroundColor,
                ),
                ...[
                  for (var i = 0,
                          angleInDegrees = this.angleInDegrees ?? 0.0,
                          count = children.length,
                          step = this.step ?? 90.0 / (count - 1);
                      i < count;
                      i++, angleInDegrees += step)
                    ExpandingActionButton(
                      directionInDegrees: angleInDegrees,
                      maxDistance: distance,
                      progress: controller.expandAnimation,
                      child: children[i],
                    ),
                ],
                OpenExpandingFab(
                  backgroundColor: backgroundColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
