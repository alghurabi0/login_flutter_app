class THelperFunctions {
  static String generateSessionId() {
    // Implement session ID generation logic here
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
