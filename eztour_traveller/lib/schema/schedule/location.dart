import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'day')
  int? day;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'from')
  String? from;

  @JsonKey(name: 'to')
  String? to;

  @JsonKey(name: 'team_id')
  int? tourId;

  Location({
    this.id,
    this.name,
    this.image,
    this.day,
    this.description,
    this.from,
    this.to,
    this.tourId,
  });


  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

}