import 'package:flutter/material.dart';

import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/services.dart';

class DateTile extends StatelessWidget {
  final DateTime updatedAt;
  final VoidCallback? onPressed;

  const DateTile({
    required this.updatedAt,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
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
              const Icon(
                Icons.calendar_month,
                color: AppColors.dateTileColor,
                size: 14,
              ),
              Text(
                timeService.customDateString("dd MMM yyyy", updatedAt),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dateTileColor,
                ),
              ),
            ],
          ),
        ),
      );
}
