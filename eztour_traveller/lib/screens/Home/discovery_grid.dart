
import 'dart:ui';

import 'package:flutter/material.dart';

class DiscoveryGrid extends StatelessWidget {

  final _items = [
    GalleryItem(name: "Food", image: "discovery_food.jpeg"),
    GalleryItem(name: "Beverage", image: "discovery_beverage.jpg"),
    GalleryItem(name: "Kids", image: "discovery_kid.jpg"),
    GalleryItem(name: "Karaoke", image: "discovery_karaoke.jpg"),
  ];

  final String title;

  DiscoveryGrid({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 25.0),),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index){
            return GalleryItemWidget(name: _items[index].name, imagePath: _items[index].image);
          }
        ),
      ],
    );
  }
}

class GalleryItem{
  final String name;
  final String image;

  GalleryItem({
    required this.name,
    required this.image,
  });
}

class GalleryItemWidget extends StatelessWidget {
  final String imagePath;
  final String name;

  const GalleryItemWidget({
    Key? key,
    required this.imagePath,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/$imagePath"),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}