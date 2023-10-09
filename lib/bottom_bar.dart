import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("首页", style: TextStyle(color: Colors.black, fontSize: 12)),
          Text("开发中", style: TextStyle(color: Colors.black, fontSize: 12)),
          Text("开发中", style: TextStyle(color: Colors.black, fontSize: 12)),
          Text("设置", style: TextStyle(color: Colors.black, fontSize: 12)),
        ],
      ),
    );
  }
}
