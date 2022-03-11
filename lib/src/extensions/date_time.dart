extension DateTimeX on DateTime {
  /// Use [isSameDate] to check whether the date
  ///
  /// matches with the date passed as an argument
  ///
  /// For example:
  ///
  /// Date 13 Dec 2020 12:01 AM and 13 Dec 2020 1:19 PM
  ///
  /// when compared would return [true] whereas
  ///
  /// 13 Dec 2020 and 13 Dec 2019 would return [false]
  bool isSameDate(DateTime other) {
    assert(other != null, "Date should not be null");
    return year == other.year && month == other.month && day == other.day;
  }
}
