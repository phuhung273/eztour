
import 'package:eztour_traveller/notifications/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ScheduleDetail extends StatefulWidget {
  const ScheduleDetail({Key? key}) : super(key: key);

  @override
  _ScheduleDetailState createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            title: Text("Day 1: San Francisco"),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sample_timeline1.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(32.0)
            ),
          ),
          ElevatedButton(
            child: Text('Click me'),
            onPressed: (){
              NotificationApi.showScheduledNotification(
                title: 'This is title',
                body: 'This is body',
                payload: 'this is payload',
                time: Time(21, 47)
              );
            },
          )
        ],
      ),
    );
  }
}

