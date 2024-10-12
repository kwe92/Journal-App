import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/calendar/ui/Widgets/calendar_day_container.dart';
import 'package:journal_app/features/calendar/ui/calendar_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/journal_entry_card.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:journal_app/features/shared/ui/hideable_mood_count.dart';
import 'package:journal_app/features/shared/ui/widgets/snappable_widget.dart';
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
    final smallDevice = deviceSizeService.smallDevice;

    return ViewModelBuilder<CalendarViewModel>.reactive(
      viewModelBuilder: () => CalendarViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(focusedDay),
      builder: (context, model, _) => BaseScaffold(
        title: 'Calendar',
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SnappableWidget(
              backgroundColor: Theme.of(context).colorScheme.surface,
              toolbarHeight: MediaQuery.of(context).size.height / (!smallDevice ? 2.5 : 1.925),
              title: TableCalendar<JournalEntry>(
                rowHeight: 42,
                daysOfWeekHeight: 24,
                headerStyle: HeaderStyle(
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  formatButtonPadding: EdgeInsets.symmetric(horizontal: !smallDevice ? 16.0 : 12.0, vertical: 4.0),
                  formatButtonTextStyle: TextStyle(
                    fontSize: !smallDevice ? 16.0 : 14.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  formatButtonDecoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.mainThemeColor, width: 2),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                ),
                calendarStyle: CalendarStyle(
                  markersAnchor: 0.125,
                  markerSizeScale: 0.125,
                  markerMargin: const EdgeInsets.symmetric(horizontal: 0.5),
                  rangeHighlightColor: AppColors.mainThemeColor.withOpacity(0.25),
                  markerDecoration: const BoxDecoration(
                    color: Color(0xff087fd0),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  todayDecoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
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
                onDaySelected: model.onDaySelected,
                onRangeSelected: model.onRangeSelected,
                onFormatChanged: (format) {
                  if (model.calendarFormat != format) {
                    model.setCalendarFormat(format);
                  }
                },
                onPageChanged: (focusedDay) => model.setFocusedDay(focusedDay),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontSize: !smallDevice ? 18 : 14),
                  weekendStyle: TextStyle(fontSize: !smallDevice ? 18 : 14),
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, day, focusedDay) => CalendarDayContainer(day: day.day),
                  rangeStartBuilder: (context, day, focusedDay) => CalendarDayContainer(day: day.day, isRange: true),
                  rangeEndBuilder: (context, day, focusedDay) => CalendarDayContainer(day: day.day, isRange: true),
                  headerTitleBuilder: (context, day) => Padding(
                    padding: EdgeInsets.only(right: !smallDevice ? 0.0 : 8.0),
                    child: !smallDevice
                        ? Text(
                            timeService.customDateString('MMM y', day),
                          )
                        : FittedBox(
                            child: Text(
                              timeService.customDateString('MMM y', day),
                            ),
                          ),
                  ),
                  // prioritizedBuilder: (context, day, focusedDay) => Text(
                  //   '${day.day}',
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  // withinRangeBuilder: (context, day, focusedDay) => Text('5'),
                  // outsideBuilder: (context, day, focusedDay) => Text('6'),
                  // disabledBuilder: (context, day, focusedDay) => Text('7'),
                  // holidayBuilder: (context, day, focusedDay) => Text('8'),
                  // defaultBuilder: (context, day, focusedDay) => Text('9'),
                  // rangeHighlightBuilder: (context, day, isWithinRange) => Text(''),
                  // singleMarkerBuilder: (context, day, event) => Text('11'),
                  // markerBuilder: (context, day, events) => Text(''),
                  // dowBuilder: (context, day) => Text('13'),
                  // weekNumberBuilder: (context, weekNumber) => Text('15'),
                ),
              ),
            ),
            const HideableMoodCount<CalendarViewModel>(),
            SliverToBoxAdapter(child: gap6),
          ],
          body: ListView.builder(
            itemCount: model.filteredSelectedEvents.length,
            itemBuilder: (context, index) => JournalEntryCard(
              index: index,
              journalEntry: model.filteredSelectedEvents[index],
            ),
          ),
        ),
      ),
    );
  }
}
