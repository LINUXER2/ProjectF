import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(alignment: AlignmentDirectional.center, child: const Text("SettingsPage", style: TextStyle(color: Colors.red, fontSize: 20)));
  }
}
