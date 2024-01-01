import 'package:auto_route/auto_route.dart';
import 'package:entry/entry.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/add_button.dart';
import 'package:journal_app/features/journal/ui/widget/filter_button.dart';
import 'package:journal_app/features/journal/ui/widget/journal_entry_card.dart';
import 'package:journal_app/features/journal/ui/widget/mood_type_counter.dart';
import 'package:journal_app/features/journal/ui/widget/side_menu.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/ui/widgets/profile_icon.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JournalViewModel>.reactive(
      viewModelBuilder: () => JournalViewModel(),
      onViewModelReady: (JournalViewModel model) async {
        await model.initialize();
      },
      builder: (context, JournalViewModel model, child) {
        return BaseScaffold(
          // means Thoughts in french
          title: "Pensées",
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ProfileIcon(
                userFirstName: model.currentUser?.firstName ?? "P",
                onPressed: () => appRouter.push(const ProfileSettingsRoute()),
              ),
            ),
          ],
          body: model.isBusy
              ? circleLoader
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                    child: JournalEntryCard(
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
          drawer: SideMenu(logoutCallback: () async {
            await model.cleanResources();
            await appRouter.replace(SignInRoute());
          }),
          // BUTTON TO ADD NEW ENTRY
          floatingActionButton: AddButton(onTap: () {
            appRouter.push(const MoodRoute());
          }),
        );
      },
    );
  }
}
