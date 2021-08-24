import 'package:json_annotation/json_annotation.dart';

part 'schedule_list_request.g.dart';

@JsonSerializable()
class ScheduleListRequest {

  ScheduleListRequest();

  factory ScheduleListRequest.fromJson(Map<String, dynamic> json) =>
      _$ScheduleListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleListRequestToJson(this);

}