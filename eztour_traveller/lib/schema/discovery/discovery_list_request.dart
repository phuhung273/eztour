import 'package:json_annotation/json_annotation.dart';

part 'discovery_list_request.g.dart';

@JsonSerializable()
class DiscoveryListRequest {

  DiscoveryListRequest();

  factory DiscoveryListRequest.fromJson(Map<String, dynamic> json) =>
      _$DiscoveryListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoveryListRequestToJson(this);

}