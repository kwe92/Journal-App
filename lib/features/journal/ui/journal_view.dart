import 'package:auto_route/auto_route.dart';
import 'package:entry/entry.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/add_button.dart';
import 'package:journal_app/features/journal/ui/widget/filter_button.dart';
import 'package:journal_app/features/journal/ui/widget/journal_entry.dart';
import 'package:journal_app/features/journal/ui/widget/mood_type_counter.dart';
import 'package:journal_app/features/journal/ui/widget/side_menu.dart';
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

        debugPrint("\nJournal entries from JournalView: ${model.journalEntries}");
      },
      // ! could a refresh method be used here instead of rebuilding the widget on insert?
      createNewViewModelOnInsert: true,
      builder: (context, model, child) {
        return BaseScaffold(
          // Thoughts in french
          title: "Pensées",
          body: model.isBusy
              ? circleLoader
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO: disappear on scroll or make transparent somehow
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 8.0, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MoodTypeCounter(moodType: MoodType.awesome, moodCount: model.awesomeCount),
                                MoodTypeCounter(moodType: MoodType.happy, moodCount: model.happyCount),
                                MoodTypeCounter(moodType: MoodType.okay, moodCount: model.okayCount),
                                MoodTypeCounter(moodType: MoodType.bad, moodCount: model.badCount),
                                MoodTypeCounter(moodType: MoodType.terrible, moodCount: model.terribleCount),
                              ],
                            ),
                          ),
                          const FilterButton()
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ListView.builder(
                          // used to center Text widget when there are no entries
                          shrinkWrap: model.journalEntries.isEmpty ? true : false,
                          itemCount: model.journalEntries.isEmpty ? 1 : model.journalEntries.length,
                          itemBuilder: (BuildContext context, int i) {
                            return model.journalEntries.isEmpty
                                ? const Entry.opacity(
                                    duration: Duration(milliseconds: 600),
                                    child: Text(
                                      "No entries, whats on your mind...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.lightGreen,
                                        fontSize: 32,
                                      ),
                                    ),
                                  )
                                : Entry.opacity(
                                    duration: const Duration(milliseconds: 600),
                                    child: JournalEntry(
                                      index: i,
                                      journalEntry: model.journalEntries[i],
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
          // Open menu to the side
          drawer: const SideMenu(),
          // BUTTON TO ADD NEW ENTRY
          floatingActionButton: AddButton(onTap: () {
            appRouter.push(const MoodRoute());

            // push add entry route and pop all routes to trigger createNewViewModelOnInsert
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


