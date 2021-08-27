import 'package:json_annotation/json_annotation.dart';

part 'checklist_request.g.dart';

@JsonSerializable()
class ChecklistRequest {

  ChecklistRequest();

  factory ChecklistRequest.fromJson(Map<String, dynamic> json) =>
      _$ChecklistRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistRequestToJson(this);

}