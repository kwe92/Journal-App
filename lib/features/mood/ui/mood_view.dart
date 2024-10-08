import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/addEntry/ui/add_entry_view.dart';
import 'package:journal_app/features/mood/ui/mood_view_model.dart';
import 'package:journal_app/features/mood/ui/widgets/cancel_button.dart';
import 'package:journal_app/features/mood/ui/widgets/mood_card.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/ui/widgets/custom_page_route_builder.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class MoodView extends StatelessWidget {
  const MoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoodViewModel>.reactive(
      viewModelBuilder: () => MoodViewModel(),
      builder: (context, viewModel, _) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Column(
              children: [
                gap16,
                Align(
                  alignment: Alignment.centerRight,
                  child: CancelButton(onPressed: () => Navigator.of(context).pop()),
                ),
                gap16,
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Entry.opacity(
                          duration: const Duration(milliseconds: 600),
                          child: Text(
                            "How are you feeling today?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              fontFamily: FontFamily.playwrite.name,
                            ),
                          ),
                        ),
                        gap48,
                        Flexible(
                          child: GridView.builder(
                            itemCount: viewModel.moods.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 24,
                              // represents the width / height respectively
                              childAspectRatio: (5 / 8),
                            ),
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap:
                                    // anonymous closure that saves the state of the index integer above within its scope
                                    () {
                                  // set selected mood
                                  viewModel.setIndex(i);

                                  viewModel.setMoodType(viewModel.moods[i].moodText);
                                },
                                child: Entry.opacity(
                                  duration: const Duration(milliseconds: 600),
                                  child: MoodCard(
                                    // determine if the card is currently selected or not
                                    isSelected: viewModel.selectedIndex == i ? true : false,
                                    mood: viewModel.moods[i],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Entry.opacity(
                          duration: const Duration(milliseconds: 600),
                          child: SelectableButton(
                              labelPadding: const EdgeInsets.symmetric(vertical: 16),
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  CustomPageRouteBuilder.sharedAxisTransition(
                                    transitionType: SharedAxisTransitionType.scaled,
                                    pageBuilder: (_, __, ___) => AddEntryView(
                                      moodType: viewModel.moodType,
                                    ),
                                  ),
                                );
                              },
                              label: "Continue"),
                        ),
                        !deviceSizeService.smallDevice ? const Gap(48) : const Gap(20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// GridView.builder

//   - build a grid based on a list of elements

//  SliverGridDelegateWithFixedCrossAxisCount

//    - controls GridView.builder children layout

// Flexible wrapping in Flex, Row or Column Widgets for GridView.builder

//   - to insure height or width is not unbound