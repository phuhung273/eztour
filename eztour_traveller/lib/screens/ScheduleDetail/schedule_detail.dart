
import 'package:eztour_traveller/notifications/notification_api.dart';
import 'package:eztour_traveller/screens/ScheduleDetail/schedule_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class ScheduleDetail extends StatelessWidget {

  final ScheduleDetailController controller = Get.put(ScheduleDetailController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
          () => Column(
          children: [
            AppBar(
              title: Text("Day ${controller.day.value.toString()}: San Francisco"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              height: 200.0,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/sample_timeline1.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(32.0)
              ),
            ),
            ElevatedButton(
              onPressed: (){
                showScheduledNotification(
                  title: 'This is title',
                  body: 'This is body',
                  payload: 'this is payload',
                  time: const Time(21, 47)
                );
              },
              child: const Text('Click me'),
            )
          ],
        ),
      ),
    );
  }
}

