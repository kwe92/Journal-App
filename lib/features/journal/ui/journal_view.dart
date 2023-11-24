import 'package:auto_route/auto_route.dart';
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/features/shared/models/entry.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:journal_app/app/theme/colors.dart';

final entriesJSON = [
  <String, dynamic>{
    "createdDate": "03-16-2023",
    "entry": "Begin, to begin is half the work let half still remain, again beginthis and thou wilt have finished.",
  },
  <String, dynamic>{
    "createdDate": "04-03-2023",
    "entry": "The man who thinks he can and the man who thinks he can't are both right.",
  },
  <String, dynamic>{
    "createdDate": "05-19-2023",
    "entry": "Trust in the lord with all thin heart, lean not unto thin own understanding.",
  },
  <String, dynamic>{
    "createdDate": "06-07-2023",
    "entry":
        "Every kingdom divided against itself is brought to desolation; and every city or house divided against itself shall not stand.",
  },
  <String, dynamic>{
    "createdDate": "07-11-2023",
    "entry": "The imagination is literally the workshop wherein are fashioned all plans created by man.",
  },
  <String, dynamic>{
    "createdDate": "08-16-2023",
    "entry":
        "Develop an attitude of gratitude, and give thanks for everything that happens to you, knowing that every step forward is a step toward achieving something bigger and better than your current situation."
  },
  <String, dynamic>{
    "createdDate": "09-22-2023",
    "entry": "Have an attitude of gratitude.",
  },
];

final entries = entriesJSON
    .map(
      (entryJSON) => Entry(
        createdDate: entryJSON["createdDate"],
        entry: entryJSON["entry"],
      ),
    )
    .toList();

@RoutePage()
class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "MyJournel",
      leading: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset("assets/images/menu_icon.svg"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.blue0,
              AppColors.blueGrey0,
            ],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(
            left: 24,
            top: 32,
            right: 24,
            bottom: 32,
          ),
          // padding: EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: AppColors.journalBackground.withOpacity(0.25),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: ListView.builder(
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: EdgeInsets.only(top: i == 0 ? 32 : 0, bottom: 42),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(entries[i].createdDate),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      // TODO: replace with navigation to entry view
                      onTap: () => appRouter.push(
                        EntryRoute(entry: entries[i]),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 24, right: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 52,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(52 / 2),
                          ),
                        ),
                        child: Text(
                          entries[i].entry,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: AddButton(onTap: () {}),
    );
  }
}

// BUTTON

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 64;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          left: 32,
          top: 32,
          right: 32,
          bottom: 56,
        ),
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.offGrey,
          borderRadius: BorderRadius.all(
            Radius.circular(size / 2),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.offWhite,
          size: 52,
        ),
      ),
    );
  }
}

// ENTRY MODEL
