import 'dart:async';

import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsServiceImpl extends AnalyticsService {
  AnalyticsServiceImpl();

  final analytics = FirebaseAnalytics.instance;

  @override
  Future<void>? setCurrentPage({String? pageName}) {
    return logEvent(name: pageName);
  }

  @override
  Future<void> setUserId(String id) => analytics.setUserId(id: id);

  @override
  Future<void> setUserProperties(
      {required String name, required String value}) {
    return analytics.setUserProperty(name: name, value: value);
  }

  @protected
  Future<void>? logEvent(
      {required String? name, Map<String, dynamic>? parameters}) {
    if (isMobile) {
      return analytics
          .logEvent(name: name!, parameters: parameters!)
          .then((_) => onSuccess(name, parameters))
          .catchError(onError);
    } else {
      onError(
        MyException('Error: Not logging firebase analytics.'),
        StackTrace.current,
      );
      return null;
    }
  }

  @override
  FirebaseAnalytics getAnalyticsClient() {
    return analytics;
  }

  @override
  FutureOr onError(dynamic error, StackTrace stk);

  @override
  void onSuccess(String? name, Map<String, dynamic>? parameters);
}
