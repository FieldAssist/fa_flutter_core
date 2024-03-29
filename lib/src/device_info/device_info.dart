import 'package:fa_flutter_core/fa_flutter_core.dart';

abstract class DeviceInfo {
  String get brand;

  String get manufacturer;

  String get model;

  String get os;

  int? get sdk;

  String get id;

  /// If IMEI is not provided then it will send "NA"
  String get imei;
}

class IosDeviceInfoImpl implements DeviceInfo {
  final IosDeviceInfo iosDeviceInfo;
  final String? imeiNo;

  const IosDeviceInfoImpl({required this.iosDeviceInfo, this.imeiNo});

  @override
  String get brand => 'Apple Inc';

  @override
  String get manufacturer => 'Apple Inc';

  @override
  String get model => iosDeviceInfo.model ?? UnknownDeviceInfoImpl().model;

  @override
  String get os => '${iosDeviceInfo.systemName} ${iosDeviceInfo.systemVersion}';

  @override
  int? get sdk => 0;

  @override
  String get id =>
      iosDeviceInfo.identifierForVendor ?? UnknownDeviceInfoImpl().id;

  /// If IMEI is not provided then it will send "NA"
  @override
  String get imei => imeiNo ?? UnknownDeviceInfoImpl().imei;
}

class AndroidDeviceInfoImpl implements DeviceInfo {
  final AndroidDeviceInfo androidDeviceInfo;
  final String? imeiNo;

  const AndroidDeviceInfoImpl(
      {required this.androidDeviceInfo, required this.imeiNo});

  @override
  String get brand => androidDeviceInfo.brand;

  @override
  String get manufacturer => androidDeviceInfo.manufacturer;

  @override
  String get model => androidDeviceInfo.model;

  @override
  String get os => 'Android ${androidDeviceInfo.version.release}';

  @override
  int get sdk => androidDeviceInfo.version.sdkInt;

  @override
  String get id => androidDeviceInfo.id;

  /// If IMEI is not provided then it will send "NA"
  @override
  String get imei => imeiNo ?? UnknownDeviceInfoImpl().imei;
}

class UnknownDeviceInfoImpl implements DeviceInfo {
  const UnknownDeviceInfoImpl();

  @override
  String get brand => "NA";

  @override
  String get manufacturer => "NA";

  @override
  String get model => "NA";

  @override
  String get os => "NA";

  @override
  int get sdk => 0;

  @override
  String get id => "NA";

  @override
  String get imei => "NA";
}
