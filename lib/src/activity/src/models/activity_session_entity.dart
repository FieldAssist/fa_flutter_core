import 'package:realm/realm.dart';

import 'activity_session.dart';

part 'activity_session_entity.realm.dart';

@RealmModel()
class _ActivitySessionEntity {
  @PrimaryKey()
  late String guid;
  late String name;

  late int startTime;

  late String source;

  late String moduleEnum;

  late String? subModuleEnum;

  late int? endTime;
}

extension ActivitySessionEntityX on ActivitySessionEntity {
  ActivitySession toModel() => ActivitySession(
        guid: guid,
        name: name,
        moduleEnum: _byName(ActivityModule.values, moduleEnum) ??
            ActivityModule.generalTrade,
        startTime: startTime,
        subModuleEnum: _byName(ActivitySubModule.values, subModuleEnum),
        endTime: endTime,
        source: _sourceFromStorage(source),
      );

  static ActivitySessionEntity fromModel(ActivitySession session) =>
      ActivitySessionEntity(
        session.guid,
        session.name,
        session.startTime,
        _sourceToStorage(session.source),
        session.moduleEnum.name,
        subModuleEnum: session.subModuleEnum?.name,
        endTime: session.endTime,
      );

  static String _sourceToStorage(ActivitySource source) => switch (source) {
        ActivitySource.sfa => 'SFA',
        ActivitySource.faOne => 'FA_ONE',
      };

  static ActivitySource _sourceFromStorage(String value) => switch (value) {
        'FA_ONE' => ActivitySource.faOne,
        _ => ActivitySource.sfa,
      };

  static T? _byName<T extends Enum>(List<T> values, String? name) {
    if (name == null) {
      return null;
    }
    for (final value in values) {
      if (value.name == name) {
        return value;
      }
    }
    return null;
  }
}
