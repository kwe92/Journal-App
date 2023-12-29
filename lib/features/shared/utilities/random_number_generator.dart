import 'dart:math';

/// Generates pseudo random non-negative rational numbers.
class RandomNumberGenerator {
  const RandomNumberGenerator._();

  static final _generator = Random();

  /// Generates a non-negative random integer uniformly distributed in the range from 0 or [start], inclusive, to [max], exclusive.
  static int randIntRange({int min = 0, required int max}) {
    return _generator.nextInt(max) + min;
  }

  /// Generates a non-negative random double uniformly distributed in the range from 0 or [start], inclusive, to 1 or [max], exclusive.
  static double randDoubleRange({int min = 0, int max = 1}) {
    return (_generator.nextDouble() * max) + min;
  }
}
