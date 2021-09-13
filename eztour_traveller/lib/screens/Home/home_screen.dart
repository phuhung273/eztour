
import 'package:eztour_traveller/screens/Home/announcement_card.dart';
import 'package:eztour_traveller/screens/Home/checklist_card.dart';
import 'package:eztour_traveller/screens/Home/discovery_grid.dart';
import 'package:eztour_traveller/screens/Home/home_screen_controller.dart';
import 'package:eztour_traveller/screens/Home/location_carousel.dart';
import 'package:eztour_traveller/widgets/moment_carousel.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class HomeScreen extends StatelessWidget {

  final HomeScreenController _controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: (){},
            ),
            title: Text(_controller.greeting.value),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: _controller.logOut,
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 200.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/sample_timeline1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                _buildHometownClock(),
                LocationCarousel(
                  title: 'Schedule',
                  locations: _controller.locations,
                  borderRadius: 20.0,
                  initialPage: _controller.initialPage.value,
                  key: UniqueKey(),
                ),
                _buildNoticesTabbar(),
                MomentCarousel(
                  title: 'Sharing Moments',
                  imagePathList: _controller.locations.map((e) => e.image).toList(),
                  borderRadius: 10.0,
                ),
                DiscoveryGrid(
                  title: 'Discovery',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNoticesTabbar() {
    return _controller.todos.isEmpty ? const CircularProgressIndicator()
        : DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.green,
                  tabs: const [
                    Tab(text: "Checklist"),
                    Tab(text: "Announcement"),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicator: RectangularIndicator(
                    bottomLeftRadius: 100,
                    bottomRightRadius: 100,
                    topLeftRadius: 100,
                    topRightRadius: 100,
                    horizontalPadding: 24,
                  ),
                ),
                SizedBox(
                  height: 350.0,
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ChecklistCard(
                            todos: _controller.todos
                        ),
                        AnnouncementCard(
                            announcements: _controller.announcements
                        ),
                      ]
                  ),
                ),
              ],
            ),
          );
  }
}

Widget _buildHometownClock() {

  String _getCurrentVNTimeString() {
    // Vietnam: ICT ~ WIB
    return DateFormat('dd/MM/yyyy hh:mm a').format(curDateTimeByZone(zone: 'WIB'));
  }

  return Container(
    padding: const EdgeInsets.all(4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Flag.fromString(
          'vn',
          height: 30,
          width: 50,
          fit: BoxFit.fill,
          replacement: Text('Viet Nam'),
        ),
        Container(width: 8.0),
        const Icon(Icons.schedule),
        Container(width: 8.0),
        StreamBuilder(
            stream: Stream.periodic(const Duration(minutes: 1)),
            builder: (context, snapshot) => Text(
              _getCurrentVNTimeString(),
              style: const TextStyle(fontSize: 18.0),
            )
        ),
      ],
    ),
  );
}