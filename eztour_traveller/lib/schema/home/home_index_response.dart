import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:eztour_traveller/schema/checklist/todo_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_index_response.g.dart';

@JsonSerializable()
class HomeIndexResponse {

  @JsonKey(name: 'greeting')
  String greeting;

  @JsonKey(name: 'todoCategories')
  List<TodoCategory> todoCategories;

  @JsonKey(name: 'announcements')
  List<Announcement> announcements;

  @JsonKey(name: 'start_date')
  String startDate;

  @JsonKey(name: 'max_day')
  int maxDay;

  HomeIndexResponse({
    required this.greeting,
    required this.todoCategories,
    required this.announcements,
    required this.startDate,
    required this.maxDay,
  });

  factory HomeIndexResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeIndexResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeIndexResponseToJson(this);

}