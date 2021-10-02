
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/screens/main/main_screen_controller.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

import 'discovery_slider.dart';
import 'home_screen_controller.dart';
import 'location_carousel.dart';
import 'notice_tabbar.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toDiscoveryScreen;

  const HomeScreen({
    required this.toDiscoveryScreen,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final HomeScreenController _controller = Get.put(HomeScreenController());

  final MainScreenController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            // snap: true,
            // floating: true,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: (){},
            ),
            // title: Text(_controller.greeting.value),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: _mainController.logOut,
              )
            ],
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_controller.greeting.value),
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          _controller.image.value,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: const Alignment(0.0, 0.2),
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.0),
                          Colors.black,
                        ],
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: _buildHometownClock(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: defaultPadding,
                    top: defaultSpacing,
                    bottom: defaultSpacing
                  ),
                  child: LocationCarousel(
                    title: 'Schedule',
                    locations: _controller.locations,
                    borderRadius: 15.0,
                    initialPage: _controller.initialPage.value,
                    key: UniqueKey(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultSpacing),
                  child: _buildNoticesTabBar(),
                ),
                InkWell(
                  onTap: widget.toDiscoveryScreen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultSpacing),
                    child: DiscoverySlider(
                      title: 'Discovery',
                    ),
                  ),
                ),
                const Divider(height: defaultSpacing)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNoticesTabBar() {
    return _controller.todoCategories.isEmpty ? const CircularProgressIndicator()
        : NoticeTabBar(
        todoCategories: _controller.todoCategories,
        announcementCategories: _controller.announcementCategories
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