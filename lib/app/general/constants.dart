// All of the constants used throughout the applicaton i.e. (Classes with only static fields and Enumerations)
// All classes implemented in this module should be const and not have the ability to be instantiated
// using ClassName._() creates a private named constructor to prevent instantiation

/// shared preference keys.
class PrefKeys {
  const PrefKeys._();

  static const accessToken = "jwt";
  static const appMode = "app_mode";
  static const notifPermissions = "notification_permissions";
}

/// MIME types used to transfer data between systems.
class MediaType {
  const MediaType._();
  static const json = "application/json";
}

/// backend API endpoint paths.
enum MoodType {
  awesome("Awesome"),
  happy("Happy"),
  okay("Okay"),
  bad("Bad"),
  terrible("Terrible");

  final String text;

  const MoodType(this.text);
}

class MoodTypeFilterOptions {
  const MoodTypeFilterOptions._();
  static const String all = 'all';
  static const String awesome = "Awesome";
  static const String happy = "Happy";
  static const String okay = "Okay";
  static const String bad = "Bad";
  static const String terrible = "Terrible";
}

/// image paths associated to mood types;
class MoodImagePath {
  const MoodImagePath._();
  static const String moodAwesome = "assets/images/very_happy_face.svg";
  static const String moodHappy = "assets/images/happy_face.svg";
  static const String moodOkay = "assets/images/meh_face.svg";
  static const String moodBad = "assets/images/sad_face.svg";
  static const String moodTerrible = "assets/images/aweful_face.svg";
}

enum FontFamily {
  playwrite('Playwrite Deutschland Grundschrift');

  final String name;

  const FontFamily(this.name);
}

enum QuoteAuthorFilterOptions {
  all('All');

  final String name;

  const QuoteAuthorFilterOptions(this.name);
}
