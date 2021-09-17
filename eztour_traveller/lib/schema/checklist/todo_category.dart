import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_category.g.dart';

@JsonSerializable()
class TodoCategory {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'todos')
  List<Todo> todos;

  TodoCategory({
    required this.id,
    required this.name,
    required this.todos,
  });

  factory TodoCategory.fromJson(Map<String, dynamic> json) =>
      _$TodoCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$TodoCategoryToJson(this);

}