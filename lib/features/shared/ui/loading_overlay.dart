import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isFullPage;

  final bool useInStack;

  const LoadingOverlay({
    this.isFullPage = false,
    this.useInStack = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return !useInStack
        ? Entry.opacity(
            child: ColoredBox(
              color: Colors.white,
              child: circleLoader,
            ),
          )
        : isFullPage
            ? Positioned(
                child: Entry.opacity(
                  child: ColoredBox(
                    color: Colors.white,
                    child: circleLoader,
                  ),
                ),
              )
            : Positioned.fill(
                child: Entry.opacity(
                  child: ColoredBox(
                    color: Colors.white,
                    child: circleLoader,
                  ),
                ),
              );
  }
}
