import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/models/photo.dart';
import 'package:journal_app/features/shared/models/photo_provider.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

//!! TODO: Should the notification methods be moved to the notification service?

class AddEntryViewModel extends ReactiveViewModel {
  final TextEditingController newEntryController = TextEditingController();

  String? _content;

  Color? _moodColor;

  DateTime? now;

  int _imageCounter = 0;

  List<Photo> _photos = [];

  List<String> _photoStrings = [];

  Map<String, ImageProvider> _imagesMap = {};

  List<ImageProvider> _images = [];

  String? get content => _content;

  Color? get moodColor => _moodColor;

  BaseUser? get currentUser => userService.currentUser;

  List<ImageProvider> get images => _images;

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

  void initialize(String moodType) {
    // set the theme for the view to the color of the mood type
    _moodColor = moodService.getMoodColorByType(moodType);

    now = DateTime.now();
  }

  void setContent(String text) {
    _content = text.trim();
    notifyListeners();
  }

  /// attempt to add entry to the backend
  Future<bool> addEntry(String moodType, String content) async {
    final newEntry = JournalEntry(
      content: content,
      moodType: moodType,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await entryStreakCounter();

    final entryID = await journalEntryService.addEntry(newEntry);

    newEntry.entryID = entryID;
    // insert images into database
    await _insertImages(entryID);

    newEntry.images = _photos;

    clearVariables();

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

  Future<void> pickImages() async {
    setBusy(true);
    // prompt user to select images
    var (List<XFile> imageFiles, String error) = await imagePickerService.pickImages();
    setBusy(false);

    // check for error
    if (error.isNotEmpty) {
      toastService.showSnackBar(
          message: error, textColor: AppColors.errorTextColor, duration: const Duration(seconds: 2, milliseconds: 500));
      return;
    }

    // retrieve image providers to be displayed in the UI
    final List<ImageProvider> imageProviders = imagePickerService.toImageProvider(imageFiles);

    if ((_images.length + imageProviders.length) <= 9) {
      // retrieve image String representations to be inserted into database
      List<String> photoStrings = await imagePickerService.convertToString(imageFiles);

      _photoStrings.addAll(photoStrings);

      _imagesMap.addAll(
        {
          for (int i = 0; i < photoStrings.length; i++) '${photoStrings[i]}-$_imageCounter': imageProviders[i],
        },
      );

      _imageCounter++;

      _images.addAll(imageProviders);

      notifyListeners();
      return;
    }

    toastService.showSnackBar(message: "Can not add more that 9 images to an entry.", textColor: AppColors.errorTextColor);
  }

  Future<void> _insertImages(int entryID) async {
    _photos = [for (String imageString in _photoStrings) Photo(entryID: entryID, imageName: imageString)];

    // insert Photo objects into database returning list of Photo id's
    List<int> photoIds = await PhotoProvider.insert(_photos);

    // assign each Photo it's respective unique id
    _photos.forEachIndexed((int index, Photo photo) => photo.id = photoIds[index]);

    debugPrint("Number of images added: ${_photos.length}");
  }

  void removeImage(ImageProvider image) {
    _imagesMap.removeWhere(_removeImage(image));

    notifyListeners();
  }

  bool Function(String, ImageProvider) _removeImage(ImageProvider image) {
    return (key, imageProvider) {
      final isMatchingImages = imageProvider == image;

      if (isMatchingImages) {
        String keyToRemove = key; // represents image name

        String imageToRemove = keyToRemove.split('-')[0];

        _images.remove(image);

        _photoStrings.remove(imageToRemove);

        debugPrint("image deleted!");
      }

      return isMatchingImages;
    };
  }

  bool userHasEnteredEntryToday(DateTime date) {
    return timeService.removeTimeStamp(date) == timeService.removeTimeStamp(DateTime.now());
  }

  bool isConsecutiveEntry(DateTime date) => (date.difference(DateTime.now()).inHours.abs() < 24);

  void clearVariables() {
    _imageCounter = 0;
    setContent('');
    _photos = [];
    _photoStrings = [];
    _images = [];
    _imagesMap = {};
    notifyListeners();
  }
}
