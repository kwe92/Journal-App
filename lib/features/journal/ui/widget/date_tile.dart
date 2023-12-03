import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/services.dart';

class DateTile extends StatelessWidget {
  final DateTime updatedAt;
  const DateTile({required this.updatedAt, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff807c7c).withOpacity(0.10),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      // TODO: add colors to app colors
      margin: const EdgeInsets.only(left: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_month,
            // TODO: add colors to app colors
            color: Color(0xff807c7c),
            size: 14,
          ),
          Text(
            timeService.customDateString("dd MMM yyyy", updatedAt),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              // TODO: maybe keep | add colors to app colors
              // color: Color(0xff898888),
              color: Color(0xff807c7c),
            ),
          ),
        ],
      ),
    );
  }
}
