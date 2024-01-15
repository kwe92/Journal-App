// TODO: move all widget keys here

import 'package:flutter/widgets.dart';

class WidgetKey {
  const WidgetKey._();

  static GlobalObjectKey initialPasswordKey = const GlobalObjectKey('initial-password');
  static GlobalObjectKey confirmPasswordKey = const GlobalObjectKey('confirm-password');
  static GlobalObjectKey firstNameKey = const GlobalObjectKey('first');
  static GlobalObjectKey lastNameKey = const GlobalObjectKey('last');
  static GlobalObjectKey phoneNumberKey = const GlobalObjectKey('phone');
  static GlobalObjectKey emailKey = const GlobalObjectKey('email');
}
