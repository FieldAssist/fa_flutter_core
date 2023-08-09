import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteLogConfigs {
  static final RemoteLogConfigs _instance = RemoteLogConfigs._();

  RemoteLogConfigs._() : _remoteConfig = FirebaseRemoteConfig.instance;

  factory RemoteLogConfigs() {
    return _instance;
  }

  final FirebaseRemoteConfig _remoteConfig;
  Future<void> init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 6),
    ));
    _remoteConfig.setDefaults(defaults);
    fetchAndActivate();
  }

  final defaults = {
    "is_log_enabled": "false",
    "company_ids": "",
    "user_ids": "",
    "severity": Severity.high.name.toLowerCase(),
  };

  bool get isLogEnabled => _remoteConfig.getBool("is_log_enabled");

  List<String> get userIds => _remoteConfig.getString("user_ids").split(",");
  List<String> get companyIds {
    print(_remoteConfig.getString("company_ids"));
    return _remoteConfig.getString("company_ids").split(",");
  }

  String get severity => _remoteConfig.getString("severity");

  void fetchAndActivate() {
    _remoteConfig.fetchAndActivate();
  }
}
