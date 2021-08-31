import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:eztour_traveller/screens/Schedule/schedule_screen_controller.dart';
import 'package:eztour_traveller/widgets/location_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/background.dart';

class ScheduleScreen extends StatelessWidget {

  final _controller = Get.put(ScheduleScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Obx((){
            if(_controller.max_day.value == 0){
              return const CircularProgressIndicator();
            }

            return ListView(
              shrinkWrap: true,
              children: _buildSchedule(_controller.locations.value as List<Location> , _controller.max_day.value),
            );
          }),
        ),
      ),
    );
  }

  List<Widget> _buildSchedule(List<Location> locations, int max_day)
  {
    final days = List<int>.generate(max_day, (i) => i + 1);

    return days.map((e) => LocationCarousel(
      title: 'Day ${e.toString()}',
      locations: locations.where((element) => element.day == e).toList(),
      borderRadius: 15.0,
    )).toList();
  }
}
