import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/features/calendar/ui/calendar_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/journal_content.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class CalendarView extends StatelessWidget {
  final DateTime focusedDay;
  const CalendarView({
    required this.focusedDay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalendarViewModel>.reactive(
      viewModelBuilder: () => CalendarViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(focusedDay),
      builder: (context, model, _) {
        return BaseScaffold(
          title: 'Calendar',
          body: Column(
            children: [
              Expanded(
                child: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, _) => [
                    SliverAppBar(
                      toolbarHeight: MediaQuery.of(context).size.height / 2.5,
                      scrolledUnderElevation: 0,
                      automaticallyImplyLeading: false,
                      // floating: required to make SliverAppBar snappable
                      floating: true,
                      // snap: required to make SliverAppBar snappable
                      snap: true,
                      title: TableCalendar<JournalEntry>(
                        daysOfWeekHeight: 24,
                        firstDay: model.minDate,
                        lastDay: DateTime.now(),
                        focusedDay: model.focusedDay,
                        selectedDayPredicate: (day) => isSameDay(model.selectedDay, day),
                        rangeStartDay: model.rangeStart,
                        rangeEndDay: model.rangeEnd,
                        calendarFormat: model.calendarFormat,
                        rangeSelectionMode: model.rangeSelectionMode,
                        eventLoader: model.getEventsForDay,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: const CalendarStyle(
                          // Use `CalendarStyle` to customize the UI
                          outsideDaysVisible: false,
                        ),
                        onDaySelected: model.onDaySelected,
                        onRangeSelected: model.onRangeSelected,
                        onFormatChanged: (format) {
                          if (model.calendarFormat != format) {
                            model.setCalendarFormat(format);
                          }
                        },
                        onPageChanged: (focusedDay) => model.setFocusedDay(focusedDay),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(fontSize: 18),
                          weekendStyle: TextStyle(fontSize: 18),
                        ),
                        calendarBuilders: const CalendarBuilders(
                            //   singleMarkerBuilder: (context, day, event) {
                            //     return Container(
                            //       height: 6,
                            //       width: 6,
                            //       margin: const EdgeInsets.only(right: 2),
                            //       color: Colors.orange,
                            //     );
                            //   },
                            // selectedBuilder: (context, day, focusedDay) {
                            //   return Container(
                            //     height: double.maxFinite,
                            //     width: double.maxFinite,
                            //     color: Colors.redAccent.withOpacity(0.25),
                            //     child: Center(child: Text('${day.day}')),
                            //   );
                            // },
                            ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Gap(12),
                    )
                  ],
                  body: ListView.builder(
                    itemCount: model.selectedEvents.length,
                    itemBuilder: (context, index) {
                      final JournalEntry entry = model.selectedEvents[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        child: JournalContent(
                          onPressed: () async => await appRouter.push(
                            EntryRoute(entry: entry),
                          ),
                          moodBackgroundColor: model.getColorByMoodType(entry.moodType).withOpacity(0.15),
                          content: entry.content,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
