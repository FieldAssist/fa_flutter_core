import 'package:rxdart/subjects.dart';

extension BehaviorSubjectX<T> on BehaviorSubject<T> {
  /// Add [data] only when stream is not closed
  ///
  /// No data is added if stream is closed
  void addDataSafely(T data) {
    if (!isClosed) {
      return sink.add(data);
    }
  }

  /// Add [error] only when stream is not closed
  ///
  /// No data is added if stream is closed
  void addErrorSafely(error) {
    if (!isClosed) {
      return sink.addError(error);
    }
  }
}
