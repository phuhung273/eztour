
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eztour_traveller/schema/schedule/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoveryCarousel extends StatelessWidget {
  final String title;
  final List<Location> locations;
  final double borderRadius;

  const DiscoveryCarousel({
    Key? key,
    required this.title,
    required this.locations,
    this.borderRadius = 5.0,
  }) : super(key: key);

  List<Widget> _buildCarouselItems(List<Location> locations){
    return locations
        .map((e) => CarouselItem(imagePath: e.image, caption: e.name, borderRadius: this.borderRadius,))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.title, style: TextStyle(fontSize: 25.0),),
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                enableInfiniteScroll: false,
                disableCenter: true,
                aspectRatio: 1.0,
                viewportFraction: 0.6,
              ),
              items: _buildCarouselItems(this.locations),
            ),
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
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
              ),
              child: Image(
                  image: AssetImage("assets/images/${this.imagePath}"),
                  width: 300,
                  fit: BoxFit.cover
              ),
              // child: Image.network(
              //     "http://10.0.2.2:8000/storage/img/locations/${this.imagePath}",
              //     width: 300.0,
              //     fit: BoxFit.cover
              // ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              this.caption,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
