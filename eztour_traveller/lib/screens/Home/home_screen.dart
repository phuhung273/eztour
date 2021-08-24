
import 'package:eztour_traveller/datasource/remote/home_service.dart';
import 'package:eztour_traveller/schema/announcement/todo.dart';
import 'package:eztour_traveller/schema/home/home_index_request.dart';
import 'package:eztour_traveller/schema/home/home_index_response.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:eztour_traveller/screens/Home/announcement_card.dart';
import 'package:eztour_traveller/screens/Home/discovery_grid.dart';
import 'package:eztour_traveller/widgets/location_carousel.dart';
import 'package:eztour_traveller/widgets/moment_carousel.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final service = HomeService(Dio(BaseOptions(contentType: "application/json")));

  String _greeting = "Good morning, Mr.A";

  final List<Location> locations = [
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 1, tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 2, tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 3, tour_id: 1),
    Location(id: 0, name: "Paris", image: "sample_timeline1.jpg", day: 4, tour_id: 1),
  ];

  // List<Todo> _todos = [];

  List<Todo> _todos = [
    Todo(id: 1, message: "Design", done: true),
    Todo(id: 2, message: "Code", done: false),
    Todo(id: 3, message: "Review", done: false),
  ];


  @override
  void initState() {
    // getHomeInfo();

    super.initState();
  }

  void getHomeInfo() async {
    String now = DateFormat.Hms().format(DateTime.now());
    try {
      HomeIndexResponse response = await service.getHomeInfo(HomeIndexRequest(local_time: now));
      setState(() {
        _greeting = response.greeting_message;
        _todos = response.todos;
      });
    } catch (e){
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){},
            ),
            title: Text(_greeting),
            actions: [
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: (){},
              )
            ],
          ),
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sample_timeline1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flag.fromString(
                  'vn',
                  height: 30,
                  width: 50,
                  fit: BoxFit.fill,
                  replacement: Text('Viet Nam'),
                ),
                Container(width: 8.0),
                Icon(Icons.schedule),
                Container(width: 8.0),
                StreamBuilder(
                    stream: Stream.periodic(const Duration(minutes: 1)),
                    builder: (context, snapshot) => Text(
                      _getCurrentVNTimeString(),
                      style: TextStyle(fontSize: 18.0),
                    )
                ),
              ],
            ),
          ),
          LocationCarousel(
            title: 'Schedule',
            locations: locations,
            borderRadius: 20.0,
          ),
          AnnouncementCard(todos: _todos),
          MomentCarousel(
            title: 'Sharing Moments',
            imagePathList: locations.map((e) => e.image).toList(),
            borderRadius: 10.0,
          ),
          DiscoveryGrid(
            title: 'Discovery',
          ),
        ],
      ),
    );
  }

  String _getCurrentVNTimeString() {
    // Vietnam: ICT ~ WIB
    return DateFormat('dd/MM/yyyy hh:mm a').format(curDateTimeByZone(zone: 'WIB'));
  }
}
