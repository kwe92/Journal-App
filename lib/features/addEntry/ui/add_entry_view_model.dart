import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/models/journal_entry_v2.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class AddEntryViewModel extends ReactiveViewModel {
  String? _content;

  Color? _moodColor;

  String? get content => _content;

  Color? get moodColor => _moodColor;

  BaseUser? get currentUser => userService.currentUser;

  DateTime? now;

  // computed variable based on content state updated with change notifier
  bool get ready {
    return _content != null && _content!.isNotEmpty;
  }

  int get continentalTime {
    return int.parse(timeService.getContinentalTime(now!));
  }

  String get dayOfWeekByName => timeService.dayOfWeekByName(now);

  String get timeOfDay => timeService.timeOfDay(now);

  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
      ];

  void initialize(String moodType, DateTime dateTime) {
    // set the theme for the view to the color of the mood type
    _moodColor = moodService.getMoodColorByType(moodType);

    now = dateTime;
  }

  void setContent(String text) {
    _content = text.trim();
    notifyListeners();
  }

  void clearContent() {
    _content = null;

    notifyListeners();
  }

  /// attempt to add entry to the backend
  Future<bool> addEntry(String moodType, String content) async {
    final newEntry = JournalEntryV2(
      content: content,
      moodType: moodType,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await journalEntryServiceV2.addEntry(newEntry);

    clearContent();

    await entryStreakCounter();

    toastService.showSnackBar(message: "New journal entry added.");

    return true;
  }

  Future<void> entryStreakCounter() async {
    if (journalEntryService.journalEntries.isEmpty) {
      await setStreakCountToOne();
      return;
    }

    final lastEnrtyDate = journalEntryService.maxDate;

    if (!userHasEnteredEntryToday(lastEnrtyDate)) {
      if (isConsecutiveEntry(lastEnrtyDate)) {
        await notifyUserOfCurrentStreakCount();
      } else {
        await setStreakCountToOne();
      }
    }
  }

  Future<void> setStreakCountToOne() async {
    await storageService.write(key: "streakCount", value: "1");

    try {
      await notificationService.instance.createNotification(
        content: NotificationContent(
          id: 1, // TODO: figure out a way to generate unique id
          channelKey: notificationService.channelKey,
          title: "First entry of the day!",
          body: "lets continue our daily practice and start a streak!",
        ),
      );
    } catch (error) {
      debugPrint("ERROR: notifyUserOfCurrentStreakCount: ${error.toString()}");
    }
  }

  Future<void> notifyUserOfCurrentStreakCount() async {
    int streakCount = int.parse(await storageService.read(key: "streakCount") ?? "0");

    streakCount++;

    await storageService.write(key: "streakCount", value: streakCount.toString());

    try {
      await notificationService.instance.createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: notificationService.channelKey,
          title: "Consistency is key!",
          body: "Congratulations you are on a $streakCount day streak!",
        ),
      );
    } catch (error) {
      debugPrint("ERROR: notifyUserOfCurrentStreakCount: ${error.toString()}");
    }
  }

  bool userHasEnteredEntryToday(DateTime date) {
    return timeService.removeTimeStamp(date) == timeService.removeTimeStamp(DateTime.now());
  }

  bool isConsecutiveEntry(DateTime date) => (date.difference(DateTime.now()).inHours.abs() < 24);
}
