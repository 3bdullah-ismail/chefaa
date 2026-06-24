import 'dart:math';

class UsernameGenerator {
  static final Random _random = Random();

  static String generate(String fullName) {
    if (fullName.isEmpty) {
      return "user_${1000 + _random.nextInt(9000)}";
    }

    final String cleaned = fullName
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), '_');

    final int suffix = 1000 + _random.nextInt(9000);

    return "${cleaned}_$suffix";
  }
}
