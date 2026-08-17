// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_session_entity.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class ActivitySessionEntity extends _ActivitySessionEntity
    with RealmEntity, RealmObjectBase, RealmObject {
  ActivitySessionEntity(
    String guid,
    String name,
    int startTime,
    String source,
    String moduleEnum, {
    String? subModuleEnum,
    int? endTime,
  }) {
    RealmObjectBase.set(this, 'guid', guid);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'startTime', startTime);
    RealmObjectBase.set(this, 'source', source);
    RealmObjectBase.set(this, 'moduleEnum', moduleEnum);
    RealmObjectBase.set(this, 'subModuleEnum', subModuleEnum);
    RealmObjectBase.set(this, 'endTime', endTime);
  }

  ActivitySessionEntity._();

  @override
  String get guid => RealmObjectBase.get<String>(this, 'guid') as String;
  @override
  set guid(String value) => RealmObjectBase.set(this, 'guid', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  int get startTime => RealmObjectBase.get<int>(this, 'startTime') as int;
  @override
  set startTime(int value) => RealmObjectBase.set(this, 'startTime', value);

  @override
  String get source => RealmObjectBase.get<String>(this, 'source') as String;
  @override
  set source(String value) => RealmObjectBase.set(this, 'source', value);

  @override
  String get moduleEnum =>
      RealmObjectBase.get<String>(this, 'moduleEnum') as String;
  @override
  set moduleEnum(String value) =>
      RealmObjectBase.set(this, 'moduleEnum', value);

  @override
  String? get subModuleEnum =>
      RealmObjectBase.get<String>(this, 'subModuleEnum') as String?;
  @override
  set subModuleEnum(String? value) =>
      RealmObjectBase.set(this, 'subModuleEnum', value);

  @override
  int? get endTime => RealmObjectBase.get<int>(this, 'endTime') as int?;
  @override
  set endTime(int? value) => RealmObjectBase.set(this, 'endTime', value);

  @override
  Stream<RealmObjectChanges<ActivitySessionEntity>> get changes =>
      RealmObjectBase.getChanges<ActivitySessionEntity>(this);

  @override
  Stream<RealmObjectChanges<ActivitySessionEntity>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ActivitySessionEntity>(this, keyPaths);

  @override
  ActivitySessionEntity freeze() =>
      RealmObjectBase.freezeObject<ActivitySessionEntity>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'guid': guid.toEJson(),
      'name': name.toEJson(),
      'startTime': startTime.toEJson(),
      'source': source.toEJson(),
      'moduleEnum': moduleEnum.toEJson(),
      'subModuleEnum': subModuleEnum.toEJson(),
      'endTime': endTime.toEJson(),
    };
  }

  static EJsonValue _toEJson(ActivitySessionEntity value) => value.toEJson();
  static ActivitySessionEntity _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'guid': EJsonValue guid,
        'name': EJsonValue name,
        'startTime': EJsonValue startTime,
        'source': EJsonValue source,
        'moduleEnum': EJsonValue moduleEnum,
      } =>
        ActivitySessionEntity(
          fromEJson(guid),
          fromEJson(name),
          fromEJson(startTime),
          fromEJson(source),
          fromEJson(moduleEnum),
          subModuleEnum: fromEJson(ejson['subModuleEnum']),
          endTime: fromEJson(ejson['endTime']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ActivitySessionEntity._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, ActivitySessionEntity,
        'ActivitySessionEntity', [
      SchemaProperty('guid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('startTime', RealmPropertyType.int),
      SchemaProperty('source', RealmPropertyType.string),
      SchemaProperty('moduleEnum', RealmPropertyType.string),
      SchemaProperty('subModuleEnum', RealmPropertyType.string, optional: true),
      SchemaProperty('endTime', RealmPropertyType.int, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
