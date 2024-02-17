import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/calendar/ui/Widgets/filter_button_calendar.dart';
import 'package:journal_app/features/calendar/ui/Widgets/mood_type_counter_calendar.dart';
import 'package:journal_app/features/calendar/ui/calendar_view_model.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class HideableMoodCountCalendar extends ViewModelWidget<CalendarViewModel> {
  const HideableMoodCountCalendar({super.key});

  @override
  Widget build(BuildContext context, CalendarViewModel viewModel) {
    return SliverAppBar(
      backgroundColor: context.watch<AppModeService>().isLightMode ? Colors.white : AppColors.darkGrey1,
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
                  MoodTypeCounterCalendar(moodType: MoodType.awesome.text, moodCount: viewModel.awesomeCount),
                  MoodTypeCounterCalendar(moodType: MoodType.happy.text, moodCount: viewModel.happyCount),
                  MoodTypeCounterCalendar(moodType: MoodType.okay.text, moodCount: viewModel.okayCount),
                  MoodTypeCounterCalendar(moodType: MoodType.bad.text, moodCount: viewModel.badCount),
                  MoodTypeCounterCalendar(moodType: MoodType.terrible.text, moodCount: viewModel.terribleCount),
                ],
              ),
            ),
            const FilterButtonCalendar()
          ],
        ),
      ),
    );
  }
}
