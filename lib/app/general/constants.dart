// All of the constants used throughout the applicaton
// All classes implemented in this module should not have the ability to be instantiated
// using ClassName._() creates a private named constructor to prevent instantiation

/// shared preference keys.
class PrefKeys {
  const PrefKeys._();

  static const accessToken = "jwt";
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
