
import 'package:flutter/material.dart';

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
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index){
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text('$index', textScaleFactor: 5),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

