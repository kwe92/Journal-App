import 'package:auto_route/auto_route.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/add_button.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => JournalViewModel(),
      onViewModelReady: (model) async {
        await model.initialize();
        debugPrint("\njournal entries from JournalView: ${model.journalEntries}");
      },
      // ! could a refresh method be used here instead of rebuilding the widget on insert?
      createNewViewModelOnInsert: true,
      builder: (context, model, child) {
        return BaseScaffold(
          title: "My Journel",
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blue0.withOpacity(0.25),
                  AppColors.blueGrey0,
                ],
              ),
            ),
            child: ListView.builder(
              itemCount: model.journalEntries.length,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: EdgeInsets.only(top: i == 0 ? 32 : 0, bottom: 42),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(model.journalEntries[i].dateString),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () => appRouter.pushAndPopUntil(EntryRoute(entry: model.journalEntries[i]), predicate: (route) => false),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 24, right: 16),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 52,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.offWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(52 / 2),
                            ),
                          ),
                          child: Text(
                            model.journalEntries[i].content,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          // Open menu to the side
          drawer: Drawer(
            // ?INFO: required to use CustomScrollView to have Spacer / Expanded Widgets within a ListView
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                    children: [
                      Image.asset('assets/images/journal_photo.avif'),
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
                                )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // BUTTON TO ADD NEW ENTRY
          floatingActionButton: AddButton(onTap: () {
            // push add entry route and pop all routes to trigger createNewViewModelOnInsert
            appRouter.pushAndPopUntil(const AddEntryRoute(), predicate: (route) => false);
          }),
        );
      },
    );
  }
}
