import 'package:json_annotation/json_annotation.dart';

part 'discovery.g.dart';

@JsonSerializable()
class Discovery {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'place')
  String place;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'about')
  String? about;

  @JsonKey(name: 'location')
  String? location;

  Discovery({
    required this.id,
    required this.title,
    required this.place,
    required this.image,
    this.address,
    this.about,
    this.location,
  });

  factory Discovery.fromJson(Map<String, dynamic> json) =>
      _$DiscoveryFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoveryToJson(this);

}