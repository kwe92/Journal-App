import 'package:auto_route/auto_route.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/mood/ui/mood_view_model.dart';
import 'package:journal_app/features/mood/ui/widgets/cancel_button.dart';
import 'package:journal_app/features/mood/ui/widgets/mood_card.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/utilities/device_size.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class MoodView extends StatelessWidget {
  const MoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoodViewModel>.reactive(
      viewModelBuilder: () => MoodViewModel(),
      builder: (context, MoodViewModel model, _) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gap16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CancelButton(onPressed: () {
                      Navigator.of(context).pop();
                    })
                  ],
                ),
                gap8,
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 200,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Entry.opacity(
                              duration: Duration(milliseconds: 600),
                              child: Text(
                                "How are you feeling today?",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        gap36,
                        Flexible(
                          child: GridView.builder(
                            itemCount: model.moods.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              // represents the width / height respectively
                              childAspectRatio: (5 / 8),
                            ),
                            itemBuilder: (BuildContext context, int i) {
                              return GestureDetector(
                                onTap:
                                    // anonymous closure that saves the state of the index integer above within its scope
                                    () {
                                  // set selected mood
                                  model.setIndex(i);

                                  // set mood type to be sent to backend
                                  model.setMoodType(model.moods[i].moodText);
                                },
                                child: Entry.opacity(
                                  duration: const Duration(milliseconds: 600),
                                  child: MoodCard(
                                    // determine if the card is currently selected or not
                                    isSelected: model.selectedIndex == i ? true : false,
                                    mood: model.moods[i],
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
                              onPressed: () {
                                appRouter.push(AddEntryRoute(moodType: model.moodType));
                              },
                              label: "Continue"),
                        ),
                        // TODO: check why we have a GAP 120 on larger devices
                        !DeviceSize.isSmallDevice(context) ? const Gap(120) : const Gap(20),
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

// Flexible wapping in Flex, Row or Column Widgets for GridView.builder

//   - to insure height or width is not unbound