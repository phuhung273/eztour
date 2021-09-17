import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'done')
  int? done = 0;

  @JsonKey(name: 'category')
  String? category;

  Todo({
    required this.id,
    required this.message,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  bool isDone(){
    return done == 1;
  }

}