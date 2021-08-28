import 'package:dio/dio.dart';
import 'package:eztour_traveller/datasource/remote/schedule_service.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:eztour_traveller/schema/schedule/schedule_list_request.dart';
import 'package:eztour_traveller/schema/schedule/schedule_list_response.dart';
import 'package:eztour_traveller/widgets/location_carousel.dart';
import 'package:flutter/material.dart';

import 'components/background.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final service = ScheduleService(Dio(BaseOptions(contentType: "application/json")));

  List<Widget> _buildSchedule(List<Location> locations, int max_day)
  {
    final days = List<int>.generate(max_day, (i) => i + 1);

    return days.map((e) => LocationCarousel(
        title: 'Day ${e.toString()}',
        locations: locations.where((element) => element.day == e).toList(),
        borderRadius: 15.0,
    )).toList();
  }

  FutureBuilder<ScheduleListResponse> _buildBody(BuildContext context){
    return FutureBuilder(
        future: service.getScheduleList(ScheduleListRequest()),
        builder: (context, snapshot){
          // if(snapshot.hasData){
          //   return ListView(
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     children: _buildSchedule(snapshot.data!.locations, snapshot.data!.max_day),
          //   );
          // } else if (snapshot.hasError) {
          //   return Text('${snapshot.error}');
          // }
          //
          // return CircularProgressIndicator();


          final List<Location> locations = [
            Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, tour_id: 1),
            Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, tour_id: 1),
            Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, tour_id: 1),
            Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 2, tour_id: 1),
            Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 3, tour_id: 1),
            Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 4, tour_id: 1),
          ];

          return ListView(
            shrinkWrap: true,
            children: _buildSchedule(locations, locations.length),
          );
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: _buildBody(context),
        ),
      ),
    );
  }
}
