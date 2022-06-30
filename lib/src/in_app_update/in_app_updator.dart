import 'package:in_app_update/in_app_update.dart';

class InAppUpdator {
  InAppUpdator({
    required this.appMinVersion,
    required this.appRecommendedVersion,
    required this.currentVersion,
  });

  final int appMinVersion;
  final int appRecommendedVersion;
  final int currentVersion;

  dynamic _error;
  AppUpdateResult? _updateResult;

  Future<bool> _checkUpdate() async {
    final _updateInfo = await InAppUpdate.checkForUpdate();

    if (_updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      if (appMinVersion > currentVersion) {
        // logger.i("****REQUIRED****");
        await _startInAppUpdateRequired();
        if (_updateResult != AppUpdateResult.success) {
          _error = "Please Update App";
          return false;
        }
      } else if (appRecommendedVersion > currentVersion) {
        // logger.i("****RECOMMENDED****");
        await _startInAppUpdateRecommended();
        return true;
      }
    }
    return true;
  }

  Future<void> _startInAppUpdateRequired() async {
    final value =
        await InAppUpdate.performImmediateUpdate().catchError((e) async {
      _error = e.toString();
    });
    _updateResult = value;

    if (_updateResult != AppUpdateResult.success) {
      _error = "Update Denied, Please Retry.";
    }
  }

  Future<void> _startInAppUpdateRecommended() async {
    final value =
        await InAppUpdate.performImmediateUpdate().catchError((e) async {
      _error = e.toString();
    });
    _updateResult = value;

    if (_updateResult != AppUpdateResult.success) {
      _error = "Update Denied, Please Retry.";
    }
  }

  String? get error => _error;

  set error(String? err) => _error = err;

  AppUpdateResult? get appUpdateResult => _updateResult;
}
