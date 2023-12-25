import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/date_tile.dart';
import 'package:journal_app/features/journal/ui/widget/journal_content.dart';
import 'package:journal_app/features/journal/ui/widget/mood_tile.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class JournalEntryCard extends ViewModelWidget<JournalViewModel> {
  final int index;
  final JournalEntry journalEntry;

  const JournalEntryCard({
    required this.index,
    required this.journalEntry,
    super.key,
  });

  @override
  Widget build(BuildContext context, JournalViewModel viewModel) {
    final Mood mood = viewModel.getMood(journalEntry.moodType);

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
            // TODO: this implementation does need to be changed to not call the journalService API multiple times
            onPressed: () => appRouter.pushAndPopUntil(EntryRoute(entry: journalEntry), predicate: (route) => false),
            moodBackgroundColor: mood.moodColorBackground,
            content: journalEntry.content,
          ),
        ],
      ),
    );
  }
}
