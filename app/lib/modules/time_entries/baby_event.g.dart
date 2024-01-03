// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BabyEventImpl _$$BabyEventImplFromJson(Map<String, dynamic> json) =>
    _$BabyEventImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      type: $enumDecode(_$BabyEventTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$BabyEventImplToJson(_$BabyEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'type': _$BabyEventTypeEnumMap[instance.type]!,
    };

const _$BabyEventTypeEnumMap = {
  BabyEventType.wakeUp: 'wakeUp',
  BabyEventType.fallAsleep: 'fallAsleep',
  BabyEventType.changeDiaper: 'changeDiaper',
};
