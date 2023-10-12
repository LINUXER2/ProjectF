import 'package:common/base/base_screen.dart';
import 'package:common/network/base_response.dart';
import 'package:common/utils/log_utils.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../model/feed_bean.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> with BaseScreenStateMixin {
  FeedBean? bean;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    BaseResponse res = await Api.getMainData();
    if (res.succeed) {
      bean = FeedBean.fromJson(res.data);
      setScreenReady();
    } else {
      setScreenError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildStatusContent();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildContent() {
    return Container(alignment: AlignmentDirectional.center, child: const Text("mainPage", style: TextStyle(color: Colors.red, fontSize: 20)));
  }
}
