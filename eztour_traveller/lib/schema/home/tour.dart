import 'package:eztour_traveller/schema/announcement/announcement_category.dart';
import 'package:eztour_traveller/schema/checklist/todo_category.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tour.g.dart';

@JsonSerializable()
class Tour {

  @JsonKey(name: 'todo_categories')
  List<TodoCategory> todoCategories;

  @JsonKey(name: 'announcement_categories')
  List<AnnouncementCategory> announcementCategories;

  @JsonKey(name: 'start_date')
  String startDate;

  @JsonKey(name: 'max_day')
  int maxDay;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'locations')
  List<Location> locations;

  Tour({
    required this.todoCategories,
    required this.announcementCategories,
    required this.maxDay,
    required this.startDate,
    required this.image,
    required this.locations,
  });

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);

  Map<String, dynamic> toJson() => _$TourToJson(this);

}