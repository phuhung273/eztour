import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_index_response.g.dart';

@JsonSerializable()
class HomeIndexResponse {

  @JsonKey(name: 'greeting')
  String greeting;

  @JsonKey(name: 'todos')
  List<Todo> todos;

  @JsonKey(name: 'announcements')
  List<Announcement> announcements;

  HomeIndexResponse({
    required this.greeting,
    required this.todos,
    required this.announcements,
  });

  factory HomeIndexResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeIndexResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeIndexResponseToJson(this);

}