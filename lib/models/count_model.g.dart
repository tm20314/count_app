// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonCountDataImpl _$$PersonCountDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonCountDataImpl(
      time: DateTime.parse(json['time'] as String),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$PersonCountDataImplToJson(
        _$PersonCountDataImpl instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'count': instance.count,
    };
