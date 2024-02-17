import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/shared/services/services.dart';

class AppModeService extends ChangeNotifier {
  late bool _isLightMode;

  bool get isLightMode => _isLightMode;

  AppModeService() {
    initialize();
  }

  Future<void> initialize() async {
    final bool isLightModeSet = await storage.containsKey(key: PrefKeys.appMode);

    !isLightModeSet ? await _setInitialLightModeOption() : await _getLightModeOptionFromStorage();
  }

  Future<void> _setInitialLightModeOption() async {
    setLightMode(true);

    await _writeLightModeOptionToStorage(_isLightMode.toString());
  }

  Future<void> _getLightModeOptionFromStorage() async {
    final isLightMode = await storage.read(key: PrefKeys.appMode);

    setLightMode((isLightMode!.toLowerCase() == "true"));
  }

  Future<void> switchMode() async {
    setLightMode(!_isLightMode);

    await _writeLightModeOptionToStorage(_isLightMode.toString());
  }

  void setLightMode(bool isLightMode) {
    _isLightMode = isLightMode;

    debugPrint("_isLightMode: $_isLightMode");

    notifyListeners();
  }

  Future<void> _writeLightModeOptionToStorage(String value) async {
    await storage.write(key: PrefKeys.appMode, value: value);
  }
}
