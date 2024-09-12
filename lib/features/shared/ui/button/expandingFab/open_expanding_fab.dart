import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/controllers/expandable_fab_controller.dart';
import 'package:provider/provider.dart';

/// a button that scales up and down, fading in and out respectively
@immutable
class OpenExpandingFab extends StatelessWidget {
  final Color? backgroundColor;
  const OpenExpandingFab({
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ExpandableFabController>();

    return IgnorePointer(
      // option to ignore button tap
      ignoring: controller.open,
      // animate size
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        // button scale
        transform: Matrix4.diagonal3Values(
          controller.open ? 0.7 : 1.0,
          controller.open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        // animate visiblity
        child: AnimatedOpacity(
          opacity: controller.open ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 250),
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          child: FloatingActionButton(
            backgroundColor: backgroundColor,
            onPressed: controller.toggle,
            child: const Icon(
              Icons.create,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
