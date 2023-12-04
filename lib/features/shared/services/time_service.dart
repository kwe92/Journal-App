import 'package:intl/intl.dart';

/// TimeService: A utility service for Durations and DateTimes that parses and formats timestamps.
class TimeService {
  /// dayOfWeekByName: returns day of week as String for DateTime object, if DateTime omitted returns current day.
  String dayOfWeekByName([DateTime? dateTime]) {
    return DateFormat.EEEE().format(dateTime ?? DateTime.now());
  }

  /// customDateString: returns formatted DateTime string with the given pattern, if DateTime omitted returns current date formatted with pattern.
  String customDateString(String pattern, [DateTime? dateTime]) {
    return DateFormat(pattern).format(dateTime ?? DateTime.now());
  }

  /// timeOfDay: returns hh:mm as String for DateTime object, if DateTime omitted returns current hh:mm.
  String timeOfDay([DateTime? dateTime]) {
    return DateFormat.jm().format(dateTime ?? DateTime.now()).replaceAll("PM", "pm").replaceAll("AM", "am");
  }

  /// getStringFromDate: returns string representation of DateTime object in the format yyyy-MM-dd.
  String getStringFromDate(DateTime dataTime) {
    return DateFormat("yyyy-MM-dd").format(dataTime.toUtc());
  }

  /// getHour24: returns the hour from 0-23
  String getHour24(DateTime dateTime) {
    return DateFormat.H().format(dateTime);
  }
}


// DateFormat

//   - formate and parse dates in a locale sensitve manner
//   - the default for formatting and parsing is en_US

// Skeletons | Formatting Specifications

//   - a set of formatting specifications that come with named constructors
//   - you can pass the Skeleton as a String but using the named constructors are preferred
//   - you can pass a string for custom Formatting
//   - see the full formatting list here: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html