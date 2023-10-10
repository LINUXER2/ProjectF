import 'package:flutter/material.dart';

typedef OnBottomTabClicked = void Function(int index);

class BottomBarItem extends StatelessWidget {
  final String text;
  final String img;
  final int index;
  final bool selected;
  final OnBottomTabClicked? onTap;

  const BottomBarItem({Key? key, required this.index, required this.text, required this.img, required this.selected, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image(image: AssetImage(img), width: 30, height: 30, fit: BoxFit.contain, color: selected ? Colors.blue : Colors.grey),
          Text(text, style: TextStyle(color: selected ? Colors.blue : Colors.grey, fontSize: 12)),
        ]),
      ),
      onTap: () {
        onTap?.call(index);
      },
    );
  }
}
