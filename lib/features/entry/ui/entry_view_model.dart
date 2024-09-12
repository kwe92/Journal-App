// ignore_for_file: prefer_final_fields

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/models/photo.dart';
import 'package:journal_app/features/shared/models/photo_provider.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class EntryViewModel extends ReactiveViewModel {
  final TextEditingController entryController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final FocusNode entryFocus = FocusNode();

  final JournalEntry entry;

  String? _content;

  Color? _moodColor;

  int _imageCounter = 0;

  Map<String, ImageProvider> _imagesMap = {};

  List<Photo?> _imagesToDelete = [];

  List<String> _updatedPhotoStrings = [];

  List<ImageProvider> _images = [];

  List<Photo> _photos = [];

  List<ImageProvider> get images => _images;

  bool _readOnly = true;

  String? get content => _content;

  bool get isIdenticalContent => content == entry.content.trim() && entry.images == [...entry.images, ..._photos];

  bool get readOnly => _readOnly;

  int get continentalTime {
    return int.parse(timeService.getContinentalTime(entry.updatedAt.toLocal()));
  }

  String get dayOfWeekByName => timeService.dayOfWeekByName(entry.updatedAt.toLocal());

  String get timeOfDay => timeService.timeOfDay(entry.updatedAt.toLocal());

  Color? get moodColor => _moodColor;

  BaseUser? get _currentUser => userService.currentUser;

  BaseUser? get currentUser => _currentUser;

  EntryViewModel({required this.entry});

// required override for ReactiveViewModel to react to changes in a service
  @override
  List<ListenableServiceMixin> get listenableServices => [
        userService,
      ];

  void initialize() {
    setContent(entry.content);
    entryController.text = _content!;
    _moodColor = moodService.getMoodColorByType(entry.moodType);

    _imagesMap = entry.images.isNotEmpty ? imagePickerService.imageFromBase64StringAsMap(entry.images) : {};

    _images = _imagesMap.values.toList();
  }

  void setContent(String text) {
    _content = text.trim();
    notifyListeners();
  }

  void clearContent() {
    _content = null;

    _imageCounter = 0;

    _imagesMap = {};

    _imagesToDelete = [];

    _updatedPhotoStrings = [];
    _images = [];

    _photos = [];

    notifyListeners();
  }

  void setReadOnly(bool isReadOnly) {
    _readOnly = isReadOnly;
    notifyListeners();
  }

  /// update journal entry
  Future<void> updateEntry() async {
    // insert images into database
    await _insertImages(entry.entryID!);

    final JournalEntry updatedEntry = JournalEntry(
      entryID: entry.entryID,
      content: content ?? '',
      moodType: entry.moodType,
      createdAt: entry.createdAt,
      images: [...entry.images, ..._photos],
      updatedAt: DateTime.now(),
    );

    await journalEntryService.updateEntry(updatedEntry);

    debugPrint("_imagesToDelete: $_imagesToDelete");

    // delete images marked for deletion from the database
    await PhotoProvider.deleteMulti(_imagesToDelete);

    clearContent();

    toastService.showSnackBar(
      message: "Updated journal entry successfully.",
    );

    notifyListeners();
  }

  /// delete journal entry via API call to backend
  Future<bool> deleteEntry(JournalEntry entry) async {
    await runBusyFuture(journalEntryService.deleteEntry(entry));

    clearContent();
    toastService.showSnackBar(message: "Deleted journal entry successfully.");

    return true;
  }

  /// popup menu warning the user of permanent entry deletion
  Future<bool> continueDelete(BuildContext context, Color color) async {
    return await toastService.popupMenu<bool>(
      context,
      color: color,
      parameters: const PopupMenuParameters(
        title: "Delete Entry",
        content: "Are you sure you want to delete this entry?",
        defaultResult: false,
        options: {
          "Delete Entry": true,
          "Cancel": false,
        },
      ),
    );
  }

  void markImageForDeletion(ImageProvider image) {
    String imageToRemove = '';
    String keyToRemove = '';
    Photo? imageMarkedForRemoval;

    _imagesMap.removeWhere((key, value) {
      final isMatchingValue = value == image;
      if (isMatchingValue) {
        keyToRemove = key; // represents image name

        imageToRemove = keyToRemove.split('-')[0]; // remove hyphen added to track duplicate images

        // mark first occurence of image for deletion
        imageMarkedForRemoval = entry.images.firstWhere(
          (photo) => photo?.imageName == imageToRemove,
          orElse: () => Photo(entryID: 0, imageName: ''),
        );

        entry.images.remove(imageMarkedForRemoval);

        // add marked image to list of images to delete upon updating
        _imagesToDelete.add(imageMarkedForRemoval);
      }

      return isMatchingValue;
    });

    // logic to remove updated images
    if (imageMarkedForRemoval?.id == null) {
      _updatedPhotoStrings.remove(imageToRemove);
    }

    _images.remove(image);

    debugPrint("images marked for deletion: ${_imagesToDelete.length}");

    notifyListeners();
  }

  Future<void> pickImages() async {
    var (List<XFile> imageFiles, String error) = await imagePickerService.pickImages();

    // check for error
    if (error.isNotEmpty) {
      toastService.showSnackBar(
        message: error.toString(),
        textColor: AppColors.errorTextColor,
      );
      return;
    }

    final imageProviders = imagePickerService.toImageProvider(imageFiles);

    if ((_images.length + imageProviders.length) <= 9) {
      List<String> updatedPhotoStrings = await imagePickerService.convertToString(imageFiles);

      _images.addAll(imageProviders);

      // convert image files into string representations to be inserted into database
      _updatedPhotoStrings.addAll(updatedPhotoStrings);

      final providerMap = {
        for (var i = 0; i < updatedPhotoStrings.length; i++) '${_updatedPhotoStrings[i]}-$_imageCounter': imageProviders[i]
      };

      _imagesMap.addAll(providerMap);

      _imageCounter++;

      notifyListeners();
      return;
    }
    toastService.showSnackBar(
      message: "images are limited to 9 per note.",
      textColor: AppColors.errorTextColor,
    );
  }

  Future<void> _insertImages(int entryID) async {
    _photos = [
      for (String imageString in _updatedPhotoStrings)
        Photo(
          entryID: entryID,
          imageName: imageString,
        ),
    ];

    List<int> photoIds = await PhotoProvider.insert(_photos);

    _photos.forEachIndexed((index, Photo photo) => photo.id = photoIds[index]);
  }

  void cancelEdit() {
    entry.images = [...entry.images, ..._imagesToDelete];
    notifyListeners();
  }
}


// DateTime.toLocal()

//   - Return DateTime value in the local timezone of the user
//   - should use to ensure the value matches what the back end sends

