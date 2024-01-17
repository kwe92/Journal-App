import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/filter_button.dart';
import 'package:journal_app/features/journal/ui/widget/mood_type_counter.dart';
import 'package:stacked/stacked.dart';

class HideableMoodCount extends ViewModelWidget<JournalViewModel> {
  const HideableMoodCount({super.key});

  @override
  Widget build(BuildContext context, JournalViewModel viewModel) {
    return SliverAppBar(
      toolbarHeight: 32,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      // floating: required to make SliverAppBar snappable
      floating: true,
      // snap: required to make SliverAppBar snappable
      snap: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 0, top: 8.0, right: 16),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MoodTypeCounter(moodType: MoodType.awesome.text, moodCount: viewModel.awesomeCount),
                  MoodTypeCounter(moodType: MoodType.happy.text, moodCount: viewModel.happyCount),
                  MoodTypeCounter(moodType: MoodType.okay.text, moodCount: viewModel.okayCount),
                  MoodTypeCounter(moodType: MoodType.bad.text, moodCount: viewModel.badCount),
                  MoodTypeCounter(moodType: MoodType.terrible.text, moodCount: viewModel.terribleCount),
                ],
              ),
            ),
            const FilterButton()
          ],
        ),
      ),
    );
  }
}
