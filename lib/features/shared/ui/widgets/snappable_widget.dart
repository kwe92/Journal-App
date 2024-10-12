import 'package:flutter/material.dart';

class SnappableWidget extends SliverAppBar {
  const SnappableWidget({
    required super.backgroundColor,
    required super.title,
    super.forceElevated,
    super.shadowColor,
    super.surfaceTintColor,
    double? toolbarHeight,
    double? scrolledUnderElevation,
    bool? automaticallyImplyLeading,
    bool? floating,
    bool? snap,
    super.key,
  }) : super(
          toolbarHeight: toolbarHeight ?? 65,
          // causes background color to look faded if not set to 0
          scrolledUnderElevation: scrolledUnderElevation ?? 0,
          automaticallyImplyLeading: automaticallyImplyLeading ?? false,
          // floating: required to make SliverAppBar snappable
          floating: floating ?? true,
          // snap: required to make SliverAppBar snappable
          snap: snap ?? true,
        );
}
