import 'package:common/base/base_screen.dart';
import 'package:common/base/events.dart';
import 'package:common/constant.dart';
import 'package:common/utils/config.dart';
import 'package:common/utils/log_utils.dart';
import 'package:common/utils/system_utils.dart';
import 'package:common/widgets/animTabBar.dart';
import 'package:common/widgets/extendedTabController.dart';
import 'package:flutter/material.dart';
import 'package:main/model/tab_item.dart';
import 'package:main/page/sub_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> with BaseScreenStateMixin, TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<TabItem> _tabs;
  late ExtendedTabController _controller;

  static const String _tag = "MainPageState";

  @override
  void initState() {
    super.initState();
    LogUtils.d(_tag, "initState");
    _initTabs();
    _controller = ExtendedTabController(length: _tabs.length, vsync: this);
    setScreenReady();
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildStatusContent();
  }

  @override
  Widget buildContent() {
    return Column(
      children: [
        _buildTabs(),
        Expanded(child: _buildTabViews()),
      ],
    );
  }

  _initTabs() {
    _tabs = [];
    _tabs.add(TabItem(0, "音乐"));
    _tabs.add(TabItem(1, "电影"));
    _tabs.add(TabItem(2, "游戏"));
    _tabs.add(TabItem(3, "时政"));
    _tabs.add(TabItem(4, "体育"));
    _tabs.add(TabItem(5, "本地"));
    _tabs.add(TabItem(6, "娱乐"));
    _tabs.add(TabItem(7, "视频"));
    _tabs.add(TabItem(8, "美食"));
  }

  Widget _buildAnimTabs() {
    return AnimTabBar(
      titles: _tabs.map((e) => e.tabName).toList(),
      controller: _controller,
      selectedFontSize: 26,
      selectedFontColor: Colors.red,
      selectedFontWeight: FontWeight.bold,
      unselectedFontSize: 18,
      unselectedFontColor: Colors.black,
      unselectedFontWeight: FontWeight.normal,
      marginStart: 6,
      marginEnd: 6,
      spacing: 10,
      showIndicator: true,
      alignment: AlignmentDirectional.bottomCenter,
      indicatorColor: Colors.black,
      maxWidthForCenter: System.width - 80,
      onTap: (int index) async {
        LogUtils.d(_tag, "onTap:$index");
        bool ret = await Config.setInt("index", index);
        LogUtils.d(_tag, "$ret,get index:${Config.getInt("index")}");
        eventCenter.emit(Constant.MESSAGE_TAB_CHANGED, index);
      },
    );
  }

  Widget _buildTabs() {
    return TabBar(
      tabs: _tabs
          .map((e) => Text(
                e.tabName,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ))
          .toList(),
      controller: _controller,
      isScrollable: true,
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      labelPadding: const EdgeInsetsDirectional.only(top: 10, start: 10, end: 10, bottom: 5),
      indicatorSize: TabBarIndicatorSize.label,
      onTap: (int index) async {
        LogUtils.d(_tag, "onTap:$index");
        bool ret = await Config.setInt("index", index);
        LogUtils.d(_tag, "$ret,get index:${Config.getInt("index")}");
        eventCenter.emit(Constant.MESSAGE_TAB_CHANGED, index);
      },
    );
  }

  Widget _buildTabViews() {
    return TabBarView(controller: _controller, children: _tabs.map((e) => SubPage(tabName: e.tabName)).toList());
  }

  @override
  bool get wantKeepAlive => true;
}
