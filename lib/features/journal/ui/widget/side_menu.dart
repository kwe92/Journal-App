import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/analytics/ui/analytics_view.dart';
import 'package:journal_app/features/calendar/ui/calendar_view.dart';
import 'package:journal_app/features/profile/profile_settings/ui/profile_settings_view.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/widgets/custom_page_route_builder.dart';

class SideMenu extends Drawer {
  SideMenu({super.key});

  final image = imageService.getRandomMindfulImage();

  @override
  Widget build(BuildContext context) => Drawer(
        // causes background color to look faded if not set to 0
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(),
        width: MediaQuery.of(context).size.width / 1.5,
        //CustomScrollView required to have Spacer / Expanded Widgets within a ListView
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Image(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer(),
                  SplashableListTileButton(
                    onTap: () async => await Navigator.of(context).push(
                      CustomPageRouteBuilder.sharedAxisTransition(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (_, __, ___) => const AnalyticsView(),
                      ),
                    ),
                    leadingIcon: const Icon(Icons.bar_chart_sharp),
                    content: "Analytics",
                  ),
                  SplashableListTileButton(
                    onTap: () async => await Navigator.of(context).push(
                      CustomPageRouteBuilder.sharedAxisTransition(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (_, __, ___) => CalendarView(focusedDay: DateTime.now()),
                      ),
                    ),
                    leadingIcon: const Icon(Icons.calendar_month_outlined),
                    content: "Calendar",
                  ),
                  SplashableListTileButton(
                    onTap: () async => await Navigator.of(context).push(
                      CustomPageRouteBuilder.sharedAxisTransition(
                          transitionDuration: const Duration(milliseconds: 800), pageBuilder: (_, __, ___) => const ProfileSettingsView()),
                    ),
                    leadingIcon: const Icon(Icons.settings),
                    content: "Settings",
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class SplashableListTileButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon leadingIcon;
  final String content;
  const SplashableListTileButton({
    required this.onTap,
    required this.leadingIcon,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Use InkWell combined with Ink to respond to
    // user touch events and provide visual fedback
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.splashColor,
      highlightColor: AppColors.splashColor,
      child: Ink(
        child: ListTile(
          leading: leadingIcon,
          title: Text(content),
        ),
      ),
    );
  }
}
