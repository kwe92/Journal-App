import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:diary_app/app/theme/colors.dart';

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

class DiaryView extends StatelessWidget {
  const DiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("MyDiary"),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset("assets/images/menu_icon.svg"),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset("assets/images/setings_icon.svg"),
            ),
          ],
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
              bottom: 48,
            ),
            decoration: BoxDecoration(
              color: AppColors.diaryBackground.withOpacity(0.25),
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 42.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(entries[i].createdDate),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 24, right: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
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
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButton: AddButton(onTap: () {}),
      ),
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

class Entry {
  final String createdDate;
  final String entry;
  const Entry({required this.createdDate, required this.entry});

  Map<String, dynamic> toMap() {
    return {
      'createdDate': createdDate,
      'entry': entry,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      createdDate: map['createdDate'] ?? '',
      entry: map['entry'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Entry.fromJson(String source) => Entry.fromMap(json.decode(source));

  @override
  String toString() => 'Entry(createdDate: $createdDate, entry: $entry)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Entry && other.createdDate == createdDate && other.entry == entry;
  }

  @override
  int get hashCode => createdDate.hashCode ^ entry.hashCode;
}
