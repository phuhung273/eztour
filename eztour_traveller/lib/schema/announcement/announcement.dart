import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

const FIELD_ID = 'id';
const FIELD_MESSAGE = 'message';
const FIELD_CATEGORY = 'category';

@JsonSerializable()
class Announcement {

  @JsonKey(name: FIELD_ID)
  String id;

  @JsonKey(name: FIELD_MESSAGE)
  String message;

  @JsonKey(name: FIELD_CATEGORY)
  String? category;

  Announcement({
    required this.id,
    required this.message,
    this.category,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  Map<String, dynamic> toJsonWithoutId() => {
    FIELD_MESSAGE: message,
    FIELD_CATEGORY: category,
  };

}