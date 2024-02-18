import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';

import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:provider/provider.dart';

class DateTile extends StatelessWidget {
  final DateTime updatedAt;
  final VoidCallback? onPressed;

  const DateTile({
    required this.updatedAt,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLightMode = context.watch<AppModeService>().isLightMode;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dateTileBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        margin: const EdgeInsets.only(left: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month,
              color: isLightMode ? AppColors.dateTileColor : Colors.white60,
              size: 14,
            ),
            gap4,
            Text(
              timeService.customDateString("MM-dd-yyyy", updatedAt),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isLightMode ? AppColors.dateTileColor : Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
