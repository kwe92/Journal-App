import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:provider/provider.dart';

class FormContainer extends StatelessWidget {
  final Widget child;
  final String dayOfWeekByName;
  final String timeOfDay;
  final int continentalTime;
  final double? height;

  const FormContainer({
    required this.dayOfWeekByName,
    required this.timeOfDay,
    required this.continentalTime,
    required this.child,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height / 1.5,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        // color: AppColors.offWhite,
        color: context.watch<AppModeService>().isLightMode ? Colors.white : AppColors.darkGrey0,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            gap8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dayOfWeekByName),
                Row(
                  children: [
                    Text(timeOfDay),
                    (continentalTime >= 19 || continentalTime <= 6) ? gap4 : gap6,
                    Icon(
                      (continentalTime >= 19 || continentalTime <= 6) ? Icons.mode_night_outlined : Icons.wb_sunny_outlined,
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
}
