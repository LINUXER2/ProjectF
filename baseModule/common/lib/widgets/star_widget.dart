import 'dart:core';

import 'package:flutter/cupertino.dart';

import '../../assets.dart';

class LightStarWidget extends StatelessWidget {
  final int totalNum;
  final int lightNum;
  final double size;

  const LightStarWidget({Key? key, required this.totalNum, required this.lightNum, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget starLight = Image(image: const AssetImage(Assets.common$assets_images_star_light_webp), width: size, height: size, fit: BoxFit.contain);
    Widget starDark = Image(image: const AssetImage(Assets.common$assets_images_star_dark_webp), width: size, height: size, fit: BoxFit.contain);
    List<Widget> stars = [];
    for (int i = 0; i < totalNum; i++) {
      if (i < lightNum) {
        stars.add(starLight);
      } else {
        stars.add(starDark);
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: stars,
    );
  }
}
