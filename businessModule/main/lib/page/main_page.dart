import 'package:common/base/base_screen.dart';
import 'package:common/network/base_response.dart';
import 'package:common/utils/log_utils.dart';
import 'package:common/utils/system_utils.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../model/feed_bean.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> with BaseScreenStateMixin,AutomaticKeepAliveClientMixin {
  List<ItemList> list = [];
  List<ItemList> bannerList = [];
  List<ItemList> feedList = [];

  static const String _tag = "MainPageState";

  @override
  void initState() {
    super.initState();
    LogUtils.d(_tag, "initState");
    _loadData();
  }

  @override
  void didUpdateWidget(MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    LogUtils.d(_tag, "didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LogUtils.d(_tag, "didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    LogUtils.d(_tag, "dispose");
  }

  Future<void> _loadData() async {
    BaseResponse res = await Api.getMainData();
    if (res.succeed) {
      list.clear();
      list.addAll(FeedBean.fromJson(res.data).issueList![0].itemList!);
      // list.map((e) => {
      //       if (e.type == "banner2") {
      //         bannerList.add(e)
      //       } else if (e.type == "video") {
      //         feedList.add(e)
      //       }
      //     });
      for (int i = 0; i < list.length; i++) {
        if (list[i].type == "banner2") {
          bannerList.add(list[i]);
        } else if (list[i].type == "video") {
          feedList.add(list[i]);
        }
      }
      setScreenReady();
    } else {
      setScreenError();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildStatusContent();
  }

  @override
  Widget buildContent() {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
      child: ListView.builder(
          cacheExtent: 240,
          itemCount: feedList.length,
          itemBuilder: (context, index) {
            return _buildItem(index);
          }),
    );
  }

  Widget _buildItem(int index) {
    return Container(
        height: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(feedList[index].data?.cover?.feed ?? "", fit: BoxFit.cover),
            Text(
              feedList[index].data?.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;

}
