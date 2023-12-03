import 'package:auto_route/auto_route.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/add_button.dart';
import 'package:journal_app/features/journal/ui/widget/journal_entry.dart';
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
          body: ListView.builder(
            // used to cented Text widget when there are no entries
            shrinkWrap: model.journalEntries.isEmpty ? true : false,
            itemCount: model.journalEntries.isEmpty ? 1 : model.journalEntries.length,
            itemBuilder: (BuildContext context, int i) {
              return model.journalEntries.isEmpty
                  ? const Center(
                      child: Text(
                        "No entries, whats on your mind...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    )
                  : JournalEntry(index: i, journalEntry: model.journalEntries[i]);
            },
          ),
          // Open menu to the side
          drawer: Drawer(
            //CustomScrollView required to have Spacer / Expanded Widgets within a ListView
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
                          ),
                        ),
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

            appRouter.push(const MoodRoute());

            // appRouter.pushAndPopUntil(const AddEntryRoute(), predicate: (route) => false);
          }),
        );
      },
    );
  }
}

// Create RenderBox That Starts at Min Height Grows to Max Height

//   - most RenderBox's have a default infinite with and height
//   - in order to have a growable RenderBox you must use a DecoratedBox widget
//   - DecoratedBox widget has a default height and width of 0
//   - wrapping DecoratedBox with a ContrainedBox and adding minimum and maximum contraints
//     allows the chidren of a DecoratedBox to be growable from the minimum size to the maximum size