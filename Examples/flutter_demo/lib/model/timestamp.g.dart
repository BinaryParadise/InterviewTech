// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timestamp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timestamp _$TimestampFromJson(Map<String, dynamic> json) => Timestamp(
      json['api'] as String,
      json['v'] as String,
      json['ret'] as List<dynamic>?,
      json['data'],
    );

Map<String, dynamic> _$TimestampToJson(Timestamp instance) => <String, dynamic>{
      'api': instance.api,
      'v': instance.v,
      'ret': instance.ret,
      'data': instance.data,
    };
