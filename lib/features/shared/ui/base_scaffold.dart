import "package:flutter/material.dart";
import "package:journal_app/app/theme/colors.dart";
import "package:journal_app/app/theme/theme.dart";
import "package:journal_app/features/shared/utilities/common_box_shadow.dart";

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Color? moodColor;
  final Widget? leading;
  final Widget? floatingActionButton;
  final Drawer? drawer;
  final Color? backgroundColor;

  const BaseScaffold({
    required this.title,
    required this.body,
    this.moodColor,
    this.leading,
    this.actions,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [CommonBoxShadow()],
          ),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            scrolledUnderElevation: 0,
            title: Text(
              title,
              style: moodColor != null ? titleLargeStyle.copyWith(foreground: Paint()..color = moodColor!) : titleLargeStyle,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: moodColor ?? AppColors.mainThemeColor,
              size: 30,
            ),
            leading: leading,
            actions: actions,
          ),
        ),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      // drawer automatically displays hamburger icon
      drawer: drawer,
    );
  }
}


// AppBar Shadow Color Without Elevation

//   - adding elevation to an AppBar changes the background color of the app bar
//     this is most noticeable when the AppBar background is set to white

//   - wrap the AppBar with a Container and wrap the Container in a PreferredSize widget to set
//     a shadow color for an AppBar through the Containers decoration propery