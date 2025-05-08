import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsService {
  Future<void> setUserId(String id);

  Future<void> setUserProperties({required String name, required String value});

  Future<void>? setCurrentPage({required String pageName});

  Future<void>? logEvent({
    required String name,
    Map<String, Object>? parameters,
  });

  FirebaseAnalytics getAnalyticsClient();

  FutureOr onError(dynamic error, StackTrace stk);

  void onSuccess(String name, Map<String, dynamic> parameters);
}
