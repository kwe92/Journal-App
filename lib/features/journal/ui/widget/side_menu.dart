import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/services.dart';

class SideMenu extends Drawer {
  final VoidCallback logoutCallback;

  SideMenu({required this.logoutCallback, super.key});

  final image = imageService.getRandomMindfulImage();

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        surfaceTintColor: Colors.white,
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
                    onTap: () async => await appRouter.push(const AnalyticsRoute()),
                    leadingIcon: const Icon(Icons.bar_chart_sharp),
                    content: "Analytics",
                  ),
                  SplashableListTileButton(
                    onTap: () async => await appRouter.push(CalendarRoute(focusedDay: DateTime.now())),
                    leadingIcon: const Icon(Icons.calendar_month_outlined),
                    content: "Calendar",
                  ),
                  SplashableListTileButton(
                    onTap: () async => await appRouter.push(const ProfileSettingsRoute()),
                    leadingIcon: const Icon(Icons.person_outline),
                    content: "Profile",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SplashableListTileButton(
                      onTap: logoutCallback,
                      leadingIcon: const Icon(Icons.logout),
                      content: "Logout",
                    ),
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
