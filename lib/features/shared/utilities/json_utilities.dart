import 'package:intl/intl.dart';

/// getStringFromDate: returns string representation of DateTime object in the format yyyy-MM-dd.
String getStringFromDate(DateTime dataTime) {
  final DateFormat formatter = DateFormat("yyyy-MM-dd");

  return formatter.format(dataTime.toUtc());
}
