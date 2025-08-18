extension NumExtension on num {
  /// Returns 0 if the number is negative, otherwise returns the original value
  num nonNegative() {
    return this < 0 ? 0 : this;
  }
}
