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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  color: AppColors.shadowColor,
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
              ]),
              child: AppBar(
                title: Text(title),
                centerTitle: true,
                iconTheme: const IconThemeData(
                  color: AppColors.appBar,
                  size: 30,
                ),
                leading: leading,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(
                      "assets/images/setings_icon.svg",
                      color: AppColors.appBar,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: body,
          floatingActionButton: floatingActionButton,
          // drawer automaticall displays hamburger icon
          drawer: drawer,
        ),
      );
}

// AppBar Shadow Color Without Elevation

//   - adding elevation to an AppBar changes the background color of the app bar
//     this is most noticible when the AppBar background is set to white

//   - wrap the AppBar with a Container and wrap the Container in a PreferredSize widget to set
//     a shadow color for an AppBar through the Containers decoration propery