// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivitySession _$ActivitySessionFromJson(Map<String, dynamic> json) =>
    _ActivitySession(
      guid: json['Guid'] as String,
      name: json['Name'] as String,
      moduleEnum: $enumDecode(_$ActivityModuleEnumMap, json['ModuleEnum']),
      startTime: (json['StartTime'] as num).toInt(),
      subModuleEnum: $enumDecodeNullable(
          _$ActivitySubModuleEnumMap, json['SubModuleEnum']),
      endTime: (json['EndTime'] as num?)?.toInt(),
      source: $enumDecodeNullable(_$ActivitySourceEnumMap, json['Source']) ??
          ActivitySource.sfa,
    );

Map<String, dynamic> _$ActivitySessionToJson(_ActivitySession instance) =>
    <String, dynamic>{
      'Guid': instance.guid,
      'Name': instance.name,
      'ModuleEnum': _$ActivityModuleEnumMap[instance.moduleEnum]!,
      'StartTime': instance.startTime,
      'SubModuleEnum': _$ActivitySubModuleEnumMap[instance.subModuleEnum],
      'EndTime': instance.endTime,
      'Source': _$ActivitySourceEnumMap[instance.source]!,
    };

const _$ActivityModuleEnumMap = {
  ActivityModule.generalTrade: 'generalTrade',
  ActivityModule.faOne: 'faOne',
  ActivityModule.embeddedGtFaOne: 'embeddedGtFaOne',
};

const _$ActivitySubModuleEnumMap = {
  ActivitySubModule.gtPinPage: 'gtPinPage',
  ActivitySubModule.faOneSocialTap: 'faOneSocialTap',
  ActivitySubModule.faOneLearningTap: 'faOneLearningTap',
  ActivitySubModule.faOneLeaderboardTap: 'faOneLeaderboardTap',
  ActivitySubModule.faOneSfaTap: 'faOneSfaTap',
  ActivitySubModule.faOneHomePageLand: 'faOneHomePageLand',
  ActivitySubModule.faOneSocialSession: 'faOneSocialSession',
  ActivitySubModule.faOneLearningSession: 'faOneLearningSession',
  ActivitySubModule.embeddedGtFaOneSession: 'embeddedGtFaOneSession',
};

const _$ActivitySourceEnumMap = {
  ActivitySource.sfa: 'SFA',
  ActivitySource.faOne: 'FA_ONE',
};
