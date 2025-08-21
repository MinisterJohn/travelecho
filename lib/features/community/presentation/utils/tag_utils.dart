class TagUtils {
  static bool containsSpecialCharacters(String text) {
    final RegExp specialChars = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return specialChars.hasMatch(text);
  }
}
