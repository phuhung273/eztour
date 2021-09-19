
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/screens/main/main_screen_controller.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

import 'discovery_slider.dart';
import 'home_screen_controller.dart';
import 'location_carousel.dart';
import 'moment_grid.dart';
import 'notice_tabbar.dart';

class HomeScreen extends StatelessWidget {

  final HomeScreenController _controller = Get.put(HomeScreenController());
  final MainScreenController _mainController = Get.find();

  final List<String> images = [
    "https://uae.microless.com/cdn/no_image.jpg",
    "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
    "https://ae01.alicdn.com/kf/HTB11tA5aiAKL1JjSZFoq6ygCFXaw/Unlocked-Samsung-GALAXY-S2-I9100-Mobile-Phone-Android-Wi-Fi-GPS-8-0MP-camera-Core-4.jpg_640x640.jpg",
    "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
    "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
    "https://media.onthemarket.com/properties/6191869/797156548/composite.jpg",
    "https://media.onthemarket.com/properties/6191840/797152761/composite.jpg",
  ];

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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/paris_night.jpg',
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
                // Container(
                //   height: 200.0,
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage("assets/images/paris_night.jpg"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
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
                    title: 'schedule',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultSpacing),
                  child: SharingGrid(
                    title: 'Sharing Moments',
                    imagePathList: images,
                    borderRadius: 10.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultSpacing),
                  child: DiscoverySlider(
                    title: 'Discovery',
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
        : NoticeTabBar(todoCategories: _controller.todoCategories, announcements: _controller.announcements);
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