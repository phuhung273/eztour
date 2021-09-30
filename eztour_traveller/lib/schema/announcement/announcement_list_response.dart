import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'announcement_list_response.g.dart';

@JsonSerializable()
class AnnouncementListResponse {

  @JsonKey(name: 'data')
  List<Announcement> announcements;

  AnnouncementListResponse({
    required this.announcements,
  });

  factory AnnouncementListResponse.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementListResponseToJson(this);

}