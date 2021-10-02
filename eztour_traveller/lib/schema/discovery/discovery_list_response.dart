import 'package:json_annotation/json_annotation.dart';

import 'discovery.dart';

part 'discovery_list_response.g.dart';

@JsonSerializable()
class DiscoveryListResponse {

  @JsonKey(name: 'data')
  List<Discovery> discoveries;

  DiscoveryListResponse({
    required this.discoveries,
  });

  factory DiscoveryListResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscoveryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoveryListResponseToJson(this);

}