import 'package:eztour_traveller/schema/announcement/todo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_index_response.g.dart';

@JsonSerializable()
class HomeIndexResponse {

  @JsonKey(name: 'greeting')
  String greeting_message;

  List<Todo> todos;

  HomeIndexResponse({
    required this.greeting_message,
    required this.todos,
  });

  factory HomeIndexResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeIndexResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeIndexResponseToJson(this);

}