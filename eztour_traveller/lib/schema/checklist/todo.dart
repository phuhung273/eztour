import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

const FIELD_ID = 'id';
const FIELD_MESSAGE = 'message';
const FIELD_DONE = 'done';
const FIELD_CATEGORY = 'category';

@JsonSerializable()
class Todo {

  @JsonKey(name: FIELD_ID)
  String? id;

  @JsonKey(name: FIELD_MESSAGE)
  String message;

  @JsonKey(name: FIELD_DONE)
  int? done = 0;

  @JsonKey(name: FIELD_CATEGORY)
  String? category;

  Todo({
    this.id,
    required this.message,
    this.done,
    this.category,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  bool isDone(){
    return done == 1;
  }

  void toggle(){
    done = isDone() ? 0 : 1;
  }

  Map<String, dynamic> toJsonWithoutId() => {
    FIELD_MESSAGE: message,
    FIELD_DONE: done,
    FIELD_CATEGORY: category,
  };
}