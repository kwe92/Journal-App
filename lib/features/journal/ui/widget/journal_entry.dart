import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/journal/ui/widget/date_tile.dart';
import 'package:journal_app/features/journal/ui/widget/journal_content.dart';
import 'package:journal_app/features/journal/ui/widget/mood_tile.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/models/entry.dart';
import 'package:journal_app/features/shared/records/mood_record.dart';
import 'package:journal_app/features/shared/services/services.dart';

class JournalEntry extends StatelessWidget {
  final int index;

  final Entry journalEntry;

  const JournalEntry({
    required this.index,
    required this.journalEntry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MapEntry<String, MoodRecord> moodMap = MoodsData.getMoodMap(journalEntry.moodType);

    final Mood mood = Mood(
      moodColor: moodMap.value.color,
      moodImagePath: moodMap.value.imagePath,
      imageSize: 20,
      moodText: journalEntry.moodType,
    );

    return Container(
      padding: EdgeInsets.only(top: index == 0 ? 32 : 0, bottom: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DateTile(
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
            onPressed: () => appRouter.pushAndPopUntil(EntryRoute(entry: journalEntry), predicate: (route) => false),
            moodBackgroundColor: mood.moodColorBackground,
            content: journalEntry.content,
          ),
        ],
      ),
    );
  }
}
