import 'dart:convert';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/shared/services/services.dart';

class WeightedMood {
  final String mood;

  final DateTime createdAt;

  double get weight {
    return switch (mood) {
      MoodTypeFilterOptions.awesome => 1.0,
      MoodTypeFilterOptions.happy => 0.75,
      MoodTypeFilterOptions.okay => 0.5,
      MoodTypeFilterOptions.bad => 0.25,
      MoodTypeFilterOptions.terrible => 0.0,
      String() => 0.0,
    };
  }

  const WeightedMood({
    required this.mood,
    required this.createdAt,
  });

  @override
  String toString() => 'WeightedMood(mood: $mood, createdAt: $createdAt)';

  Map<String, dynamic> toMap() {
    return {
      'mood': mood,
      'createdAt': timeService.removeTimeStamp(createdAt),
      'weight': weight,
    };
  }

  factory WeightedMood.fromMap(Map<String, dynamic> map) {
    return WeightedMood(
      mood: map['mood'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightedMood.fromJson(String source) => WeightedMood.fromMap(json.decode(source));
}
