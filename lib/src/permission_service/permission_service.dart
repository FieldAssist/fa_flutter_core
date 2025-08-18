import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> request(Permission appPermission) async {
    var status = await appPermission.status;
    if (status.isGranted) return true;
    if (status.isDenied) {
      status = await appPermission.request();
      return status.isGranted;
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }
}
