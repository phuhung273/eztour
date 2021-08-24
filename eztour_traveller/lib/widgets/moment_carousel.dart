
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MomentCarousel extends StatelessWidget {
  final String title;
  final List<String> imagePathList;
  final double borderRadius;

  const MomentCarousel({
    Key? key,
    required this.title,
    required this.imagePathList,
    this.borderRadius = 5.0,
  }) : super(key: key);

  List<Widget> _buildCarouselItems(List<String> imagePathList){
    return imagePathList
        .map((e) => CarouselItem(imagePath: e, borderRadius: this.borderRadius,))
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
                height: 150.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                enableInfiniteScroll: false,
                disableCenter: true,
                aspectRatio: 1.0,
                viewportFraction: 0.6,
              ),
              items: _buildCarouselItems(this.imagePathList),
            ),
          )
        ],
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final double borderRadius;

  const CarouselItem({
    Key? key,
    required this.imagePath,
    required this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
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
    );
  }
}
