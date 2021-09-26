import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'message')
  String message;

  Announcement({
    required this.id,
    required this.message,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

}