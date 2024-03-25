import 'package:intl/intl.dart';

/// Utility service for Duration's and DateTime's to parse and format timestamps.
class TimeService {
  /// Returns day of week as String for DateTime object, if DateTime omitted returns current day.
  String dayOfWeekByName([DateTime? dateTime]) {
    return DateFormat.EEEE().format(dateTime ?? DateTime.now());
  }

  /// Returns formatted DateTime string with the given pattern, if DateTime omitted returns current date formatted with pattern.
  String customDateString(String pattern, [DateTime? dateTime]) {
    return DateFormat(pattern).format(dateTime ?? DateTime.now());
  }

  /// Returns hh:mm as String for DateTime object, if DateTime omitted returns current hh:mm.
  String timeOfDay([DateTime? dateTime]) {
    return DateFormat.jm().format(dateTime ?? DateTime.now()).replaceAll("PM", "pm").replaceAll("AM", "am");
  }

  /// Returns string representation of DateTime object in the format yyyy-MM-dd.
  String getStringFromDate(DateTime dataTime) {
    return DateFormat("yyyy-MM-dd").format(dataTime.toUtc());
  }

  /// Returns the hour from 0-23
  String getContinentalTime(DateTime dateTime) {
    return DateFormat.H().format(dateTime);
  }

  /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  String removeTimeStamp(DateTime date) => DateFormat("yyyy-MM-dd").format(date);
}


// DateFormat

//   - formate and parse dates in a locale sensitve manner
//   - the default for formatting and parsing is en_US

// Skeletons | Formatting Specifications

//   - a set of formatting specifications that come with named constructors
//   - you can pass the Skeleton as a String but using the named constructors are preferred (e.g. DateFormat.EEEE())
//   - you can pass a string for custom Formatting
//   - see the full formatting list here: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html