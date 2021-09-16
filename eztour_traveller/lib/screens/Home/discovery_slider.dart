
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eztour_traveller/constants.dart';
import 'package:flutter/material.dart';

class DiscoverySlider extends StatelessWidget {

  final _items = [
    GalleryItem(
      title: "Food",
      description: 'Discover all local dishes',
      image: "discovery_food.jpeg",
      icon: Icons.restaurant
    ),
    GalleryItem(
      title: "Beverage",
      description: "Ain't better time to drink",
      image: "discovery_beverage.jpg",
      icon: Icons.local_bar
    ),
    GalleryItem(
      title: "Kids",
      description: 'For your angels',
      image: "discovery_kid.jpg",
      icon: Icons.child_care
    ),
    GalleryItem(
      title: "Karaoke",
      description: 'Anyone can sings',
      image: "discovery_karaoke.jpg",
      icon: Icons.celebration
    ),
  ];

  final String title;

  DiscoverySlider({
    Key? key,
    required this.title,
  }) : super(key: key);

  List<Widget> _buildItems(List<GalleryItem> items){
    return items.map((e) => GalleryItemWidget(item: e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Text(title, style: theme.textTheme.headline4)
        ),
        CarouselSlider(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
          ),
          items: _buildItems(_items),
        )
      ],
    );
  }
}

class GalleryItem{
  final String title;
  final String image;
  final String description;
  final IconData icon;

  GalleryItem({
    required this.title,
    required this.image,
    required this.description,
    required this.icon,
  });
}

class GalleryItemWidget extends StatelessWidget {
  final GalleryItem item;

  const GalleryItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/${item.image}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: defaultPadding),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: defaultPadding),
                  child: Icon(item.icon, color: tertiaryColor),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: theme.textTheme.subtitle1!.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      item.description,
                      style: theme.textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}