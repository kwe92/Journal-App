import 'package:flutter/material.dart';

// TODO: refactor into a service and hold the device size state in a memeber variable

/// Helper class to get device MediaQuery information
class DeviceSize {
  DeviceSize._();

  static bool isSmallDevice(BuildContext context) => MediaQuery.of(context).size.height < 700 ? true : false;
}
