import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {

  int id;
  String name;
  String image;
  int day;
  int tour_id;

  Location({
    required this.id,
    required this.name,
    required this.image,
    required this.day,
    required this.tour_id,
  });


  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

}