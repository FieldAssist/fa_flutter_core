import 'package:in_app_update/in_app_update.dart';

abstract class InAppUpdator {
  Future<bool> updateAccordingToMinOrRecommendedVersion(
      {required int appMinVersion,
      required int appRecommendedVersion,
      required int currentVersion});

  Future<bool> checkForUpdate();

  Future<bool> startInAppUpdate();

  String? get error;

  set error(String? err);

  AppUpdateResult? get appUpdateResult;
}

class InAppUpdatorImpl extends InAppUpdator {
  dynamic _error;
  AppUpdateResult? _updateResult;

  @override
  Future<bool> checkForUpdate() async {
    final _updateInfo = await InAppUpdate.checkForUpdate();

    if (_updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> updateAccordingToMinOrRecommendedVersion(
      {required int appMinVersion,
      required int appRecommendedVersion,
      required int currentVersion}) async {
    if (appMinVersion > currentVersion) {
      // logger.i("****REQUIRED****");
      await startInAppUpdate();
      if (_updateResult != AppUpdateResult.success) {
        _error = "Please Update App";
        return false;
      }
    } else if (appRecommendedVersion > currentVersion) {
      // logger.i("****RECOMMENDED****");
      await startInAppUpdate();
      return true;
    }

    return true;
  }

  @override
  Future<bool> startInAppUpdate() async {
    final value =
        await InAppUpdate.performImmediateUpdate().catchError((e) async {
      _error = e.toString();
    });
    _updateResult = value;

    if (_updateResult != AppUpdateResult.success) {
      _error = "Update Denied, Please Retry.";
      return false;
    }

    return true;
  }

  @override
  String? get error => _error;

  @override
  set error(String? err) => _error = err;

  @override
  AppUpdateResult? get appUpdateResult => _updateResult;
}
