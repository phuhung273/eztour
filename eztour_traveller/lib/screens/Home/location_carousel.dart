
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:flutter/material.dart';

class LocationCarousel extends StatelessWidget {
  final String title;
  final List<Location> locations;
  final double borderRadius;
  final int? initialPage;

  const LocationCarousel({
    Key? key,
    required this.title,
    required this.locations,
    this.borderRadius = 5.0,
    this.initialPage,
  }) : super(key: key);

  List<Widget> _buildCarouselItems(List<Location> locations){
    return locations
        .map((e) => CarouselItem(imagePath: e.image, caption: e.name, borderRadius: borderRadius,))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(title, style: theme.textTheme.headline4)
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 150.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              disableCenter: true,
              aspectRatio: 1.0,
              viewportFraction: 0.6,
              initialPage: initialPage ?? 0,
            ),
            items: _buildCarouselItems(locations),
          )
        ],
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final String caption;
  final double borderRadius;

  const CarouselItem({
    Key? key,
    required this.imagePath,
    required this.caption,
    required this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Card(
            clipBehavior: Clip.hardEdge,
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            // child: Image(
            //   image: AssetImage("assets/images/${this.imagePath}"),
            //   width: 300,
            //   fit: BoxFit.cover
            // ),
            child: Image.network(
                "$HOST_URL/storage/img/locations/$imagePath",
                width: 300.0,
                fit: BoxFit.cover
            ),
          ),
          Positioned(
            top: 10.0,
            left: -10.0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0
              ),
              child: Text(
                caption,
                style: theme.textTheme.subtitle1!.copyWith(
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
