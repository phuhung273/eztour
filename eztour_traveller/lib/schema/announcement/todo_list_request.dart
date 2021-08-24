import 'package:json_annotation/json_annotation.dart';

part 'todo_list_request.g.dart';

@JsonSerializable()
class TodoListRequest {

  TodoListRequest();

  factory TodoListRequest.fromJson(Map<String, dynamic> json) =>
      _$TodoListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListRequestToJson(this);

}