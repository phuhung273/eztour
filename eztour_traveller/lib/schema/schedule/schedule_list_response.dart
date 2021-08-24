import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_list_response.g.dart';

@JsonSerializable()
class ScheduleListResponse {

  int max_day;
  List<Location> locations;

  ScheduleListResponse({
    required this.max_day,
    required this.locations,
});

  factory ScheduleListResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleListResponseToJson(this);

}