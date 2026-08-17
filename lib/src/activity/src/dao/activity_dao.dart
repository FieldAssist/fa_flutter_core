import '../models/activity_session.dart';

/// Local store for *closed* activity sessions that are waiting to be uploaded.
abstract class ActivityDao {
  Future<List<ActivitySession>> getPendingActivities();

  Future<void> savePendingActivities(List<ActivitySession> activities);

  Future<void> addPendingActivity(ActivitySession activity);

  Future<void> removePendingActivities(List<String> guids);

  Future<void> clearPendingActivities();
}
