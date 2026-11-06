import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_session.freezed.dart';
part 'activity_session.g.dart';

enum ActivitySource {
  @JsonValue('SFA')
  sfa,
  @JsonValue('FA_ONE')
  faOne,
}

enum ActivityModule {
  @JsonValue('generalTrade')
  generalTrade(1, 'GeneralTrade'),
  @JsonValue('faOne')
  faOne(2, 'FaOne'),

  @JsonValue('embeddedGtFaOne')
  embeddedGtFaOne(3, 'EmbeddedGTFaOne');

  const ActivityModule(this.id, this.label);

  final int id;

  final String label;
}

enum ActivitySubModule {
  @JsonValue('gtPinPage')
  gtPinPage(10, 'GTPinPage'),
  @JsonValue('faOneSocialTap')
  faOneSocialTap(20, 'FaOneSocialTap'),
  @JsonValue('faOneLearningTap')
  faOneLearningTap(21, 'FaOneLearningTap'),
  @JsonValue('faOneLeaderboardTap')
  faOneLeaderboardTap(22, 'FaOneLeaderboardTap'),
  @JsonValue('faOneSfaTap')
  faOneSfaTap(23, 'FaOneSfaTap'),
  @JsonValue('faOneHomePageLand')
  faOneHomePageLand(24, 'FaOneHomePageLand'),
  @JsonValue('faOneSocialSession')
  faOneSocialSession(25, 'FaOneSocialSession'),
  @JsonValue('faOneLearningSession')
  faOneLearningSession(26, 'FaOneLearningSession'),

  @JsonValue('embeddedGtFaOneSession')
  embeddedGtFaOneSession(30, 'EmbeddedGTFaOneSession');

  const ActivitySubModule(this.id, this.label);

  final int id;

  final String label;
}

@freezed
abstract class ActivitySession with _$ActivitySession {
  factory ActivitySession({
    @JsonKey(name: 'Guid') required String guid,
    @JsonKey(name: 'Name') required String name,

    /// Which part of the product this is. Required — it is the session's
    /// identity, and `ModuleEnum` is non-nullable on the wire.
    @JsonKey(name: 'ModuleEnum') required ActivityModule moduleEnum,

    /// Epoch milliseconds.
    @JsonKey(name: 'StartTime') required int startTime,

    /// The backend's `SubModuleEnum`, or null when no value names this screen.
    /// Null is sent as null — there is no fallback, since nothing else in the
    /// session identifies which one would apply.
    @JsonKey(name: 'SubModuleEnum') ActivitySubModule? subModuleEnum,

    /// Epoch milliseconds. Null while the session is still open.
    @JsonKey(name: 'EndTime') int? endTime,
    @JsonKey(name: 'Source') @Default(ActivitySource.sfa) ActivitySource source,
  }) = _ActivitySession;

  const ActivitySession._();

  factory ActivitySession.fromJson(Map<String, dynamic> json) =>
      _$ActivitySessionFromJson(json);

  Map<String, dynamic> toApiJson() => <String, dynamic>{
        'guid': guid,
        'activityDescription': name,
        'moduleName': moduleName,
        'moduleEnum': moduleEnum.id,
        'subModuleName': subModuleName,
        'subModuleEnum': subModuleEnum?.id,
        'startTime': _toApiTimestamp(startTime),
        'endTime': _toApiTimestamp(endTime ?? startTime),
      };

  String get moduleName => moduleEnum.label;

  String? get subModuleName => subModuleEnum?.label;

  static String _toApiTimestamp(int epochMillis) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(epochMillis);
    String pad(int value) => value.toString().padLeft(2, '0');
    return '${dateTime.year}-${pad(dateTime.month)}-${pad(dateTime.day)}'
        'T${pad(dateTime.hour)}:${pad(dateTime.minute)}:${pad(dateTime.second)}';
  }

  bool get isOpen => endTime == null;

  int get durationInMillis =>
      (endTime ?? DateTime.now().millisecondsSinceEpoch) - startTime;

  bool isSameScreenAs({
    required String name,
    required ActivityModule moduleEnum,
    required ActivitySubModule? subModuleEnum,
    required ActivitySource source,
  }) =>
      this.name == name &&
      this.moduleEnum == moduleEnum &&
      this.subModuleEnum == subModuleEnum &&
      this.source == source;
}
