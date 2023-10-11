import 'package:common/export.dart';
import 'package:common/utils/log_utils.dart';
import 'package:flutter/material.dart';

import '../api.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    Response res = await Api.getMainData();
    LogUtils.d("jinn2", res.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(alignment:AlignmentDirectional.center,child: const Text("mainPage", style: TextStyle(color: Colors.red, fontSize: 20)));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
