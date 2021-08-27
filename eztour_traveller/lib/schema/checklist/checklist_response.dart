import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checklist_response.g.dart';

@JsonSerializable()
class ChecklistResponse {

  @JsonKey(name: 'todos')
  List<Todo> todos;

  ChecklistResponse({
    required this.todos,
  });

  factory ChecklistResponse.fromJson(Map<String, dynamic> json) =>
      _$ChecklistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistResponseToJson(this);

}