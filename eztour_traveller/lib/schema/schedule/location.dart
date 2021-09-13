import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'day')
  int day;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'from')
  String from;

  @JsonKey(name: 'to')
  String to;

  @JsonKey(name: 'tour_id')
  int tourId;

  Location({
    required this.id,
    required this.name,
    required this.image,
    required this.day,
    required this.description,
    required this.from,
    required this.to,
    required this.tourId,
  });


  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

}