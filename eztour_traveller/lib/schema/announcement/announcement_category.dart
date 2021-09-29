import 'package:eztour_traveller/schema/announcement/announcement.dart';
import 'package:json_annotation/json_annotation.dart';

part 'announcement_category.g.dart';

@JsonSerializable()
class AnnouncementCategory {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'announcements')
  List<Announcement> announcements;

  AnnouncementCategory({
    required this.id,
    required this.name,
    required this.announcements,
  });

  factory AnnouncementCategory.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementCategoryToJson(this);

}