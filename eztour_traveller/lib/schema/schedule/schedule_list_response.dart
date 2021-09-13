import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_list_response.g.dart';

@JsonSerializable()
class ScheduleListResponse {

  @JsonKey(name: 'max_day')
  int maxDay;

  @JsonKey(name: 'locations')
  List<Location> locations;

  @JsonKey(name: 'start_date')
  String startDate;

  ScheduleListResponse({
    required this.maxDay,
    required this.locations,
    required this.startDate,
});

  factory ScheduleListResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleListResponseToJson(this);

}