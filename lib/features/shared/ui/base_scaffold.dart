import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:journal_app/app/theme/colors.dart";

// ! may have issues when using a base scaffold and accessing Scaffold.of(context)
class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? body;
  final Widget? floatingActionButton;
  final Drawer? drawer;

  const BaseScaffold({
    required this.title,
    this.leading,
    required this.body,
    this.floatingActionButton,
    this.drawer,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: AppColors.offWhite,
              size: 30,
            ),
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
          // drawer automaticall displays hamburger icon
          drawer: drawer,
        ),
      );
}
