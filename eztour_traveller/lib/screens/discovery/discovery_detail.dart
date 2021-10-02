import 'package:eztour_traveller/constants.dart';
import 'package:eztour_traveller/screens/discovery/discovery_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoveryDetailScreen extends GetView<DiscoveryScreenController> {

  final _tag = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    final discovery = controller.findByTag(_tag);
    final theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(backgroundColor: Colors.black),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: _tag,
                  child: Image.network(
                    discovery.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultSpacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          discovery.title,
                          style: theme.textTheme.headline6!.copyWith(
                              color: Colors.white
                          )
                      ),
                      Text(
                        discovery.place,
                        style: theme.textTheme.subtitle1!.copyWith(
                            color: Colors.white
                        ),
                      ),
                      Text(
                          discovery.about ?? ''
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
