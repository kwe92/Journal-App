import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/journal/ui/widget/date_tile.dart';
import 'package:journal_app/features/journal/ui/widget/journal_content.dart';
import 'package:journal_app/features/journal/ui/widget/mood_tile.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';

class JournalEntryCard extends StatelessWidget {
  final int index;
  final JournalEntry journalEntry;
  final VoidCallback? onDateTilePressed;

  const JournalEntryCard({
    required this.index,
    required this.journalEntry,
    this.onDateTilePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: remove from view
    final Mood mood = moodService.createMoodByType(journalEntry.moodType, 20);

    return Container(
      padding: EdgeInsets.only(top: index == 0 ? 16 : 0, bottom: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DateTile(
                onPressed: onDateTilePressed,
                updatedAt: journalEntry.updatedAt,
              ),
              gap12,
              MoodTile(mood: mood),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          JournalContent(
            onPressed: () async => await appRouter.push(
              EntryRoute(entry: journalEntry),
            ),
            journalEntry: journalEntry,
            moodBackgroundColor: mood.moodColorBackground,
          ),
        ],
      ),
    );
  }
}
