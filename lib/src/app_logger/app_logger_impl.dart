import 'package:fa_flutter_core/src/app_logger/remote_config/api_logger.dart';

import '../../fa_flutter_core.dart';

class AppLoggerImpl extends AppLogImpl {
  AppLoggerImpl({super.packageName});

  UserInfo? _userInfo;

  // ignore: avoid_setters_without_getters
  set userInfo(UserInfo userInfo) {
    _userInfo = userInfo;
  }

  /// [userInfo] must be set, before calling this method
  @override
  void r(
    LogInfo logInfo, {
    Severity severity = Severity.high,
  }) {
    if (_userInfo == null) {
      d("Initialise user info before calling this method");
      return;
    }

    final isLoggingEnabled = RemoteLogConfigs().isLogEnabled;
    if (!isLoggingEnabled) {
      return;
    }

    final companyIds = RemoteLogConfigs().companyIds;
    final userIds = RemoteLogConfigs().userIds;
    if (companyIds.contains(_userInfo!.companyId) &&
        userIds.contains(_userInfo!.id)) {
      final remoteSeverity = getSeverity(RemoteLogConfigs().severity);

      if (shouldCaptureLog(
          remoteSeverity: remoteSeverity, logSeverity: severity)) {
        // Log the data to API Logger
        final logData =
            ApiLogInfo.fromLogInfo(logInfo: logInfo, userInfo: _userInfo!);

        ApiLogger().logEvent(logData);
      }
    }
  }
}
