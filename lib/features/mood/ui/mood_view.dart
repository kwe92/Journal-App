import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/mood/ui/mood_view_model.dart';
import 'package:journal_app/features/mood/ui/widgets/cancel_button.dart';
import 'package:journal_app/features/mood/ui/widgets/mood_card.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class MoodView extends StatelessWidget {
  const MoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MoodViewModel(),
      builder: (context, model, _) {
        return SafeArea(
          child: Scaffold(
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
                        gap36,
                        Flexible(
                            child: GridView.builder(
                          itemCount: MoodsData.moodsMaps.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            // represents the width / height respectively
                            childAspectRatio: (100 / 160),
                          ),
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                // set selected mood
                                model.setIndex(i);

                                // set mood type to be sent to backend
                                model.setMoodType(MoodsData.moodsMaps[i].key);
                              },
                              child: MoodCard(
                                // determine if the card is currently selected or not
                                isSelected: model.selectedIndex == i ? true : false,
                                mood: Mood(
                                    moodColor: MoodsData.moodsMaps[i].value.color,
                                    moodImagePath: MoodsData.moodsMaps[i].value.imagePath,
                                    imageSize: MoodsData.moodsMaps[i].value.defaultSize,
                                    moodText: MoodsData.moodsMaps[i].key),
                              ),
                            );
                          },
                        )),
                        SelectableButton(
                            mainTheme: lightGreenButtonTheme,
                            labelPadding: const EdgeInsets.symmetric(vertical: 16),
                            onPressed: () {
                              appRouter.push(AddEntryRoute(moodType: model.moodType));
                            },
                            label: "Continue"),
                        const Gap(120)
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

//    - controls the layout of the children of a GridView.builder

// Flexible wapping in Flex, Row or Column Widgets for GridView.builder

//   - to insure height or width is not unbound