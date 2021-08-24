import 'package:eztour_traveller/schema/announcement/todo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_list_response.g.dart';

@JsonSerializable()
class TodoListResponse {

  @JsonKey(name: 'todos')
  List<Todo> todos;

  TodoListResponse({
    required this.todos,
  });

  factory TodoListResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListResponseToJson(this);

}