import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/services.dart';

class SideMenu extends Drawer {
  final VoidCallback logoutCallback;

  SideMenu({required this.logoutCallback, super.key});

  final image = imageService.getRandomMindfulImage();

  @override
  Widget build(BuildContext context) => Drawer(
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child:
                        // Use InkWell combined with Ink to respond to
                        // user touch events and provide visual fedback
                        InkWell(
                      onTap: logoutCallback,
                      splashColor: AppColors.splashColor,
                      highlightColor: AppColors.splashColor,
                      child: Ink(
                        child: const ListTile(
                          leading: Icon(Icons.logout),
                          title: Text("Logout"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
