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

/// the set of available moods a user can be in when writing a journal entry.
class MoodType {
  const MoodType._();

  static const String awesome = "Awesome";
  static const String happy = "Happy";
  static const String okay = "Okay";
  static const String bad = "Bad";
  static const String terrible = "Terrible";
}

// image paths associated to mood types;
class MoodImagePath {
  const MoodImagePath._();
  static const String moodAwesome = "assets/images/very_happy_face.svg";
  static const String moodHappy = "assets/images/happy_face.svg";
  static const String moodOkay = "assets/images/meh_face.svg";
  static const String moodBad = "assets/images/sad_face.svg";
  static const String moodTerrible = "assets/images/aweful_face.svg";
}
