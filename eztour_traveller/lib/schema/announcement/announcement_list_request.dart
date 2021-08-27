import 'package:json_annotation/json_annotation.dart';

part 'announcement_list_request.g.dart';

@JsonSerializable()
class AnnouncementListRequest {

  AnnouncementListRequest();

  factory AnnouncementListRequest.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementListRequestToJson(this);

}