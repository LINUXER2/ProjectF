import 'package:flutter/material.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscoveryPageState();
}

class DiscoveryPageState extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(alignment: AlignmentDirectional.center, child: const Text("DiscoveryPage", style: TextStyle(color: Colors.red, fontSize: 20)));
  }
}
