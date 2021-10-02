import 'package:eztour_traveller/route/route.dart';
import 'package:eztour_traveller/widgets/hero_widget.dart';
import 'package:eztour_traveller/widgets/parallax_flow_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'discovery_controller.dart';



class DiscoveryScreen extends StatelessWidget {

  final DiscoveryScreenController _controller = Get.put(DiscoveryScreenController());

  @override
  Widget build(BuildContext context) {

    timeDilation = 1.5;

    return Obx(
      () => ListView.builder(
        itemCount: _controller.discoveries.length,
        itemBuilder: (context, index){
          final item = _controller.discoveries[index];

          return HeroWidget(
            tag: item.title, // must be id
            onTap: () => Get.toNamed(ROUTE_DISCOVERY_DETAIL, arguments: item.title),
            child: DiscoveryListItem(
              imageUrl: item.image,
              name: item.title,
              country: item.place,
            ),
          );
      }),
    );
  }
}

class DiscoveryListItem extends StatelessWidget {
  DiscoveryListItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.country,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String country;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildGradient(),
              _buildTitleAndSubtitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    final scrollable = Scrollable.of(context);
    if(scrollable == null) return Container();

    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: scrollable,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            country,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

