import 'package:auto_route/auto_route.dart';
import 'package:entry/entry.dart';
import 'package:flutter/rendering.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/add_button.dart';
import 'package:journal_app/features/journal/ui/widget/hideable_mood_count.dart';
import 'package:journal_app/features/journal/ui/widget/hideable_search_bar.dart';
import 'package:journal_app/features/journal/ui/widget/journal_entry_card.dart';
import 'package:journal_app/features/journal/ui/widget/side_menu.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
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
      onViewModelReady: (JournalViewModel model) async => await model.initialize(),
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
                    Expanded(
                      child: NestedScrollView(
                        floatHeaderSlivers: true,
                        // MOOD COUNT
                        headerSliverBuilder: (context, _) => [
                          const HideableMoodCount(),
                          HideableSearchBar(searchController: model.searchController),
                          SliverToBoxAdapter(child: gap4),
                        ],
                        body: Center(
                          // JOURNAL ENTRIES
                          child: model.journalEntries.isEmpty
                              ? const Entry.opacity(
                                  duration: Duration(milliseconds: 600),
                                  child: Text(
                                    "No entries, what's on your mind...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.lightGreen,
                                      fontSize: 32,
                                    ),
                                  ),
                                )
                              // Hide FAB on Scroll
                              : NotificationListener<UserScrollNotification>(
                                  onNotification: (notification) {
                                    if (userIsScrollingForward(notification)) {
                                      showFab(model);
                                    } else if (userIsScrollingDownward(notification)) {
                                      doNotShowFab(model);
                                    }
                                    return true;
                                  },
                                  child: ListView.builder(
                                      itemCount: model.journalEntries.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        final JournalEntry entry = model.journalEntries[i];

                                        return Entry.opacity(
                                          duration: const Duration(milliseconds: 600),
                                          child: JournalEntryCard(
                                            onDateTilePressed: () async => await appRouter.push(
                                              CalendarRoute(
                                                focusedDay: entry.updatedAt,
                                              ),
                                            ),
                                            index: i,
                                            journalEntry: entry,
                                          ),
                                        );
                                      }),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
          // OPEN SIDE MENU
          drawer: SideMenu(logoutCallback: () async {
            await model.cleanResources();
            // TODO: implement Navigator
            await appRouter.replace(SignInRoute());
          }),
          //ADD NEW ENTRY BUTTON
          floatingActionButton: model.isFabVisible
              ? AddButton(
                  onTap: () => appRouter.push(const MoodRoute()),
                )
              : null,
        );
      },
    );
  }

  bool userIsScrollingForward(UserScrollNotification notification) {
    return notification.direction == ScrollDirection.forward ? true : false;
  }

  bool userIsScrollingDownward(UserScrollNotification notification) {
    return notification.direction == ScrollDirection.reverse;
  }

  void showFab(JournalViewModel model) {
    if (!model.isFabVisible) model.setFabVisibility(true);
  }

  void doNotShowFab(JournalViewModel model) {
    if (model.isFabVisible) model.setFabVisibility(false);
  }
}
