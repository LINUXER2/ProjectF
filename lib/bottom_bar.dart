import 'package:flutter/material.dart';

import 'assets.dart';
import 'bottom_bar_item.dart';

class BottomBar extends StatefulWidget {
  final OnBottomTabClicked? onTap;
  final int currentIndex;

  const BottomBar({Key? key, required this.currentIndex, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: Colors.black)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: BottomBarItem(
                  index: 0,
                  text: '首页',
                  img: Assets.assets_images_tab_main_webp,
                  onTap: widget.onTap,
                  selected: widget.currentIndex == 0 ? true : false)),
          Expanded(
              child: BottomBarItem(
                  index: 1,
                  text: '开发中',
                  img: Assets.assets_images_tab_discovery_webp,
                  onTap: widget.onTap,
                  selected: widget.currentIndex == 1 ? true : false)),
          Expanded(
              child: BottomBarItem(
                  index: 2,
                  text: '开发中',
                  img: Assets.assets_images_tab_message_webp,
                  onTap: widget.onTap,
                  selected: widget.currentIndex == 2 ? true : false)),
          Expanded(
              child: BottomBarItem(
                  index: 3,
                  text: '设置',
                  img: Assets.assets_images_tab_settings_webp,
                  onTap: widget.onTap,
                  selected: widget.currentIndex == 3 ? true : false)),
        ],
      ),
    );
  }
}
