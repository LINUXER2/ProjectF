import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(alignment:AlignmentDirectional.center,child: const Text("mainPage", style: TextStyle(color: Colors.red, fontSize: 20)));
  }
}
