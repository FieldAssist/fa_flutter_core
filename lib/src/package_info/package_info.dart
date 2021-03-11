import 'package:fa_dart_core/fa_dart_core.dart';
import 'package:package_info/package_info.dart';

abstract class PackageInformation {
  String get appName;

  String get packageName;

  String get version;

  String get buildNumber;
}

class PackageInformationImpl implements PackageInformation {
  const PackageInformationImpl({
    required this.appName,
    required this.buildNumber,
    required this.packageName,
    required this.version,
  });

  static Future<PackageInformation> getPackageInfo() async {
    if (isMobile) {
      final packageInfo = await PackageInfo.fromPlatform();
      return PackageInformationImpl(
        appName: packageInfo.appName,
        buildNumber: packageInfo.buildNumber,
        packageName: packageInfo.packageName,
        version: packageInfo.version,
      );
    } else {
      return PackageInformationImpl(
        appName: "NA",
        buildNumber: "0",
        packageName: "NA",
        version: "NA",
      );
    }
  }

  @override
  final String appName;
  @override
  final String buildNumber;
  @override
  final String packageName;
  @override
  final String version;
}
