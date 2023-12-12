import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/services.dart';

class SideMenu extends Drawer {
  SideMenu({super.key});

  //  should this be propigated down?
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
                    child: Image.asset(
                      image,
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
                      onTap: () async {
                        // remove access token upon user logout
                        await tokenService.removeAccessTokenFromStorage();

                        // remove all routes and return to the signin page
                        appRouter.pushAndPopUntil(SignInRoute(), predicate: (route) => false);
                      },
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
