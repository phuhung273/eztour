import 'package:eztour_traveller/schema/home/tour.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_index_response.g.dart';

@JsonSerializable()
class HomeIndexResponse {

  @JsonKey(name: 'greeting')
  String greeting;

  @JsonKey(name: 'tour')
  Tour tour;

  HomeIndexResponse({
    required this.greeting,
    required this.tour,
  });

  factory HomeIndexResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeIndexResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeIndexResponseToJson(this);

}