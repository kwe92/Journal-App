import 'package:flutter/material.dart';

/// Helper class to get device MediaQuery information
class DeviceSizeService extends ChangeNotifier {
  bool _smallDevice = false;

  bool get smallDevice => _smallDevice;

  void setSmallDevice(bool isSmallDevice) {
    _smallDevice = isSmallDevice;
    debugPrint("is small device: $_smallDevice");
    notifyListeners();
  }
}
