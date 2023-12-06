import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/models/entry.dart';
import 'package:journal_app/features/shared/services/services.dart';

class FormContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final Entry? entry;

  const FormContainer({
    required this.child,
    this.height,
    this.entry,
    super.key,
  });

  static final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height / 1.5,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            gap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(timeService.dayOfWeekByName(entry != null ? entry!.updatedAt.toLocal() : now)),
                Row(
                  children: [
                    Text(timeService.timeOfDay(entry != null ? entry!.updatedAt.toLocal() : now)),
                    (hour24 >= 19 || hour24 <= 6) ? gap4 : gap6,
                    Icon(
                      (hour24 >= 19 || hour24 <= 6) ? Icons.mode_night_outlined : Icons.wb_sunny_outlined,
                    ),
                  ],
                )
              ],
            ),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }

  int get hour24 {
    return int.parse(entry != null ? timeService.getHour24(entry!.updatedAt.toLocal()) : timeService.getHour24(now));
  }
}


// DateTime.toLocal()

//   - Return DateTime value in the local timezone of the user
//   - should use to ensure the value matches what the back end sends