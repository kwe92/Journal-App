import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? body;
  final Widget? floatingActionButton;

  const BaseScaffold({
    required this.title,
    required this.leading,
    required this.body,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            leading: leading,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset("assets/images/setings_icon.svg"),
              ),
            ],
          ),
          body: body,
          floatingActionButton: floatingActionButton,
        ),
      );
}
