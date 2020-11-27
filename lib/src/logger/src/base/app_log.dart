/// [AppLog] is used to provide an abstract logger base for various
/// logging needs. Extend this class to create your own logging
/// class for every logging usage. You can replace [print] and use
/// your custom logger extended from this class

abstract class AppLog {
  /// For logging VERBOSE
  void v(dynamic object);

  /// For logging DEBUG
  void d(dynamic object);

  /// For logging some INFORMATION
  void i(dynamic object);

  /// For logging a WARNING
  void w(dynamic object);

  /// For logging an ERROR
  ///
  /// Note: If there is no stackTrace available
  /// pass [StackTrace.current]
  void e(dynamic object, StackTrace s);

  /// For logging some Unusual Behaviour
  void wtf(dynamic object);
}
