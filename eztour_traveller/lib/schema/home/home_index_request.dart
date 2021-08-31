import 'package:json_annotation/json_annotation.dart';

part 'home_index_request.g.dart';

@JsonSerializable()
class HomeIndexRequest {

  String? local_time;

  HomeIndexRequest({
    this.local_time,
  });

  factory HomeIndexRequest.fromJson(Map<String, dynamic> json) =>
      _$HomeIndexRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HomeIndexRequestToJson(this);

}