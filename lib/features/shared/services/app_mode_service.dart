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
    final hasAppModeSet = await storage.containsKey(key: PrefKeys.appMode);

    if (!hasAppModeSet) {
      _isLightMode = true;
      notifyListeners();

      await storage.write(key: PrefKeys.appMode, value: _isLightMode.toString());

      return;
    }

    final isLightMode = await storage.read(key: PrefKeys.appMode);

    _isLightMode = (isLightMode!.toLowerCase() == "true");

    notifyListeners();
    debugPrint("_isLightMode: $_isLightMode");
  }

  Future<void> switchMode() async {
    _isLightMode = !_isLightMode;
    await storage.write(key: PrefKeys.appMode, value: _isLightMode.toString());
    debugPrint("_isLightMode: $_isLightMode");

    notifyListeners();
  }
}
