import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa_flutter_core/fa_flutter_core.dart';

class ApiLogger {
  static final ApiLogger _instance = ApiLogger._();

  ApiLogger._();

  factory ApiLogger() => _instance;

  final DocumentReference _logsDocument =
      FirebaseFirestore.instance.collection('fa_logs').doc('logs');

  Future<void> init() async {
    await Firebase.initializeApp();
  }

  Future<void> logEvent(ApiLogInfo logInfo) async {
    final userCompanyIdsCollection =
        _logsDocument.collection(logInfo.userInfoBatch);

    await userCompanyIdsCollection.doc().set(logInfo.toJson());
  }
}
