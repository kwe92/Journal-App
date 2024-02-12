import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';

class CalendarDayContainer extends StatelessWidget {
  final int day;
  final bool isRange;
  const CalendarDayContainer({
    required this.day,
    this.isRange = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(4),
        height: !isRange ? double.maxFinite : 34,
        width: !isRange ? double.maxFinite : 34,
        decoration: BoxDecoration(
          color: AppColors.mainThemeColor,
          borderRadius: BorderRadius.all(
            !isRange ? const Radius.circular(6) : const Radius.circular(34 / 2),
          ),
        ),
        child: Center(
          child: Text('$day'),
        ),
      );
}
