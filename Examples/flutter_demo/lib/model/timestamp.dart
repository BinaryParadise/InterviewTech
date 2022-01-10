import 'package:json_annotation/json_annotation.dart';

part 'timestamp.g.dart';

@JsonSerializable()
class Timestamp {
  String api;
  String v;
  List? ret;
  dynamic data;

  Timestamp(this.api, this.v, this.ret, this.data);

  factory Timestamp.fromJson(Map<String, dynamic> json) =>
      _$TimestampFromJson(json);

  Map<String, dynamic> toJson() => _$TimestampToJson(this);
}
