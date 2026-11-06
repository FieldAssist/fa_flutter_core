// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivitySession {
  @JsonKey(name: 'Guid')
  String get guid;
  @JsonKey(name: 'Name')
  String get name;

  /// Which part of the product this is. Required — it is the session's
  /// identity, and `ModuleEnum` is non-nullable on the wire.
  @JsonKey(name: 'ModuleEnum')
  ActivityModule get moduleEnum;

  /// Epoch milliseconds.
  @JsonKey(name: 'StartTime')
  int get startTime;

  /// The backend's `SubModuleEnum`, or null when no value names this screen.
  /// Null is sent as null — there is no fallback, since nothing else in the
  /// session identifies which one would apply.
  @JsonKey(name: 'SubModuleEnum')
  ActivitySubModule? get subModuleEnum;

  /// Epoch milliseconds. Null while the session is still open.
  @JsonKey(name: 'EndTime')
  int? get endTime;

  /// Which app wrote the row. Local only — [moduleEnum] is what the backend
  /// reads, and the two say much the same thing.
  @JsonKey(name: 'Source')
  ActivitySource get source;

  /// Create a copy of ActivitySession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ActivitySessionCopyWith<ActivitySession> get copyWith =>
      _$ActivitySessionCopyWithImpl<ActivitySession>(
          this as ActivitySession, _$identity);

  /// Serializes this ActivitySession to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActivitySession &&
            (identical(other.guid, guid) || other.guid == guid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.moduleEnum, moduleEnum) ||
                other.moduleEnum == moduleEnum) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.subModuleEnum, subModuleEnum) ||
                other.subModuleEnum == subModuleEnum) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, guid, name, moduleEnum,
      startTime, subModuleEnum, endTime, source);

  @override
  String toString() {
    return 'ActivitySession(guid: $guid, name: $name, moduleEnum: $moduleEnum, startTime: $startTime, subModuleEnum: $subModuleEnum, endTime: $endTime, source: $source)';
  }
}

/// @nodoc
abstract mixin class $ActivitySessionCopyWith<$Res> {
  factory $ActivitySessionCopyWith(
          ActivitySession value, $Res Function(ActivitySession) _then) =
      _$ActivitySessionCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'Guid') String guid,
      @JsonKey(name: 'Name') String name,
      @JsonKey(name: 'ModuleEnum') ActivityModule moduleEnum,
      @JsonKey(name: 'StartTime') int startTime,
      @JsonKey(name: 'SubModuleEnum') ActivitySubModule? subModuleEnum,
      @JsonKey(name: 'EndTime') int? endTime,
      @JsonKey(name: 'Source') ActivitySource source});
}

/// @nodoc
class _$ActivitySessionCopyWithImpl<$Res>
    implements $ActivitySessionCopyWith<$Res> {
  _$ActivitySessionCopyWithImpl(this._self, this._then);

  final ActivitySession _self;
  final $Res Function(ActivitySession) _then;

  /// Create a copy of ActivitySession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guid = null,
    Object? name = null,
    Object? moduleEnum = null,
    Object? startTime = null,
    Object? subModuleEnum = freezed,
    Object? endTime = freezed,
    Object? source = null,
  }) {
    return _then(_self.copyWith(
      guid: null == guid
          ? _self.guid
          : guid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      moduleEnum: null == moduleEnum
          ? _self.moduleEnum
          : moduleEnum // ignore: cast_nullable_to_non_nullable
              as ActivityModule,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int,
      subModuleEnum: freezed == subModuleEnum
          ? _self.subModuleEnum
          : subModuleEnum // ignore: cast_nullable_to_non_nullable
              as ActivitySubModule?,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as int?,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as ActivitySource,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ActivitySession extends ActivitySession {
  _ActivitySession(
      {@JsonKey(name: 'Guid') required this.guid,
      @JsonKey(name: 'Name') required this.name,
      @JsonKey(name: 'ModuleEnum') required this.moduleEnum,
      @JsonKey(name: 'StartTime') required this.startTime,
      @JsonKey(name: 'SubModuleEnum') this.subModuleEnum,
      @JsonKey(name: 'EndTime') this.endTime,
      @JsonKey(name: 'Source') this.source = ActivitySource.sfa})
      : super._();
  factory _ActivitySession.fromJson(Map<String, dynamic> json) =>
      _$ActivitySessionFromJson(json);

  @override
  @JsonKey(name: 'Guid')
  final String guid;
  @override
  @JsonKey(name: 'Name')
  final String name;

  /// Which part of the product this is. Required — it is the session's
  /// identity, and `ModuleEnum` is non-nullable on the wire.
  @override
  @JsonKey(name: 'ModuleEnum')
  final ActivityModule moduleEnum;

  /// Epoch milliseconds.
  @override
  @JsonKey(name: 'StartTime')
  final int startTime;

  /// The backend's `SubModuleEnum`, or null when no value names this screen.
  /// Null is sent as null — there is no fallback, since nothing else in the
  /// session identifies which one would apply.
  @override
  @JsonKey(name: 'SubModuleEnum')
  final ActivitySubModule? subModuleEnum;

  /// Epoch milliseconds. Null while the session is still open.
  @override
  @JsonKey(name: 'EndTime')
  final int? endTime;

  /// Which app wrote the row. Local only — [moduleEnum] is what the backend
  /// reads, and the two say much the same thing.
  @override
  @JsonKey(name: 'Source')
  final ActivitySource source;

  /// Create a copy of ActivitySession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ActivitySessionCopyWith<_ActivitySession> get copyWith =>
      __$ActivitySessionCopyWithImpl<_ActivitySession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ActivitySessionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ActivitySession &&
            (identical(other.guid, guid) || other.guid == guid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.moduleEnum, moduleEnum) ||
                other.moduleEnum == moduleEnum) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.subModuleEnum, subModuleEnum) ||
                other.subModuleEnum == subModuleEnum) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, guid, name, moduleEnum,
      startTime, subModuleEnum, endTime, source);

  @override
  String toString() {
    return 'ActivitySession(guid: $guid, name: $name, moduleEnum: $moduleEnum, startTime: $startTime, subModuleEnum: $subModuleEnum, endTime: $endTime, source: $source)';
  }
}

/// @nodoc
abstract mixin class _$ActivitySessionCopyWith<$Res>
    implements $ActivitySessionCopyWith<$Res> {
  factory _$ActivitySessionCopyWith(
          _ActivitySession value, $Res Function(_ActivitySession) _then) =
      __$ActivitySessionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Guid') String guid,
      @JsonKey(name: 'Name') String name,
      @JsonKey(name: 'ModuleEnum') ActivityModule moduleEnum,
      @JsonKey(name: 'StartTime') int startTime,
      @JsonKey(name: 'SubModuleEnum') ActivitySubModule? subModuleEnum,
      @JsonKey(name: 'EndTime') int? endTime,
      @JsonKey(name: 'Source') ActivitySource source});
}

/// @nodoc
class __$ActivitySessionCopyWithImpl<$Res>
    implements _$ActivitySessionCopyWith<$Res> {
  __$ActivitySessionCopyWithImpl(this._self, this._then);

  final _ActivitySession _self;
  final $Res Function(_ActivitySession) _then;

  /// Create a copy of ActivitySession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? guid = null,
    Object? name = null,
    Object? moduleEnum = null,
    Object? startTime = null,
    Object? subModuleEnum = freezed,
    Object? endTime = freezed,
    Object? source = null,
  }) {
    return _then(_ActivitySession(
      guid: null == guid
          ? _self.guid
          : guid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      moduleEnum: null == moduleEnum
          ? _self.moduleEnum
          : moduleEnum // ignore: cast_nullable_to_non_nullable
              as ActivityModule,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as int,
      subModuleEnum: freezed == subModuleEnum
          ? _self.subModuleEnum
          : subModuleEnum // ignore: cast_nullable_to_non_nullable
              as ActivitySubModule?,
      endTime: freezed == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as int?,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as ActivitySource,
    ));
  }
}

// dart format on
