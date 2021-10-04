
import 'package:eztour_traveller/helpers/time_helpers.dart';
import 'package:eztour_traveller/notifications/notification_api.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe/swipe.dart';
import 'package:timelines/timelines.dart';

import '../../constants.dart';
import 'schedule_screen_controller.dart';

class ScheduleScreen extends StatelessWidget {

  final ScheduleScreenController _controller = Get.put(ScheduleScreenController());

  @override
  Widget build(BuildContext context) {
    return Swipe(
      onSwipeRight: _controller.back,
      onSwipeLeft: _controller.next,
      child: Obx(
        () => PageView.builder(
          itemCount: _controller.locationMap.length,
          controller: _controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {

            if(_controller.locationMap.isEmpty){
              return const Center(child: CircularProgressIndicator());
            }

            final day = index + 1;

            final position = _findSuitablePosition(_controller.locationMap[day]!, day);
            final image = position == -1
                ? '$HOST_URL/storage/img/locations/${_controller.locationMap[day]![0].image}'
                : '$HOST_URL/storage/img/locations/${_controller.locationMap[day]![position].image}';

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  title: Text("Day $day"),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        height: 200.0,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(32.0)
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                        child: _buildTimeline(_controller.locationMap[day]!, position)
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildTimeline(List<Location> locations, int position) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color: const Color(0xff989898),
        indicatorTheme: const IndicatorThemeData(
          position: 0,
          size: 20.0,
        ),
        connectorTheme: const ConnectorThemeData(
          thickness: 2.5,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: locations.length,
        contentsBuilder: (context, index) {
          final location = locations[index];

          final time = DateTime.parse('${_controller.startDate}');

          return Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  location.name!,
                  style: const TextStyle(
                      fontSize: 24.0
                  )
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${location.from}-${location.to}',
                    style: const TextStyle(
                      fontSize: 16.0
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () => showTimeScheduledNotification(
                      title:  'Eztour Remind',
                      body: _controller.name,
                      payload: 'this is payload',
                      time: const Time(21, 47)
                    ),
                    child: Container(
                      width: 64.0,
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      decoration: ShapeDecoration(
                        color: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                        )
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(location.description!),
                )
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) {
          return index == position ? const DotIndicator(
            size: 24.0,
            color: Color(0xff66c97f),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 12.0,
            ),
          )
          : const OutlinedDotIndicator(
            borderWidth: 2.5,
          );
        },
        connectorBuilder: (_, index, ___) => const SolidLineConnector(
          color: Color(0xff66c97f),
        ),
      ),
    );
  }

  int _findSuitablePosition(List<Location> locations, int day){
    final now = DateTime.now();
    final dateNow = getDateNow();

    if(now.isBefore(string2DateTime(_controller.startDate).add(Duration(days: day - 1)))
        || _controller.startDate.isEmpty) return -1;

    // debugPrint(DateTime.parse('$dateNow ${locations.first.from}').toString());
    // debugPrint(DateTime.parse('$dateNow ${locations.last.to}').toString());

    if(now.isBefore(DateTime.parse('$dateNow ${locations.first.from}'))){
      return 0;
    } else if(now.isAfter(DateTime.parse('$dateNow ${locations.last.to}'))){
      return locations.length - 1;
    }

    for(var i = 0; i < locations.length; i++){
      final location = locations[i];
      final dateFrom = DateTime.parse('$dateNow ${location.from}');
      final dateTo = DateTime.parse('$dateNow ${location.to}');
      if(now.isAfter(dateFrom) && now.isBefore(dateTo)){
        return i;
      }
    }

    return 0;
  }
}

