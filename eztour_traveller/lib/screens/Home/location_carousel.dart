
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
        SizedBox(
          height: 180.0,
          child: PageView.builder(
            padEnds: false,
            controller: PageController(
              viewportFraction: 0.8,
              initialPage: initialPage ?? 0,
            ),
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];

              return CarouselItem(
                imagePath: location.image,
                title: location.name,
                description: 'Day ${index + 1}',
                borderRadius: borderRadius,
              );
            }
          )
        )
      ],
    );
  }
}

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final double borderRadius;

  const CarouselItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.borderRadius,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const bottomMargin = 8.0;

    return Card(
      margin: const EdgeInsets.only(right: defaultPadding),
      clipBehavior: Clip.hardEdge,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  '$HOST_URL/storage/img/locations/$imagePath',
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.0, -0.2),
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.black,
                  ],
                )
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      title,
                      style: theme.textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: bottomMargin),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: theme.textTheme.bodyText2!.fontSize,
                          ),
                        ),
                        Text(
                          description,
                          style: theme.textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomMargin, right: defaultPadding),
              child: Icon(Icons.send, color: Colors.white),
            )
          ),
        ],
      ),
    );
  }
}
