import 'package:common/utils/log_utils.dart';
import 'package:common/utils/system_utils.dart';
import 'package:discovery/page/discovery_page.dart';
import 'package:flutter/material.dart';
import 'package:music/page/music_page.dart';
import 'package:news/page/main_page.dart';
import 'package:settings/page/settings_page.dart';

import 'bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final String tag = "MyHomePage";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  late List<Widget> _pages;
  late List<GlobalKey> _keys;
  int _currentIndex = 0;

  final String _tag = "_MyHomePageState";

  @override
  void initState() {
    super.initState();
    LogUtils.d(_tag, "initState");
    _pageController = PageController();
    _initPages();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LogUtils.d(
          _tag, "screen test:width:${System.width},height:${System.height},statusHeight:${System.statusHeight},ratio:${System.devicePixelRatio}");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LogUtils.d(_tag, "didChangeDependencies");
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    LogUtils.d(_tag, "didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    LogUtils.d(_tag, "dispose");
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _renderHome();
  }

  Widget _renderHome() {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]); //隐藏状态栏
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   systemOverlayStyle: SystemUiOverlayStyle.light,
      // ),
      body: Container(
          padding: EdgeInsetsDirectional.only(top: System.statusHeight),
          child: PageView(
            children: _pages,
            controller: _pageController,

            ///pageView本身没有缓存page，该参数设为true，可以预加载相邻一个page，但仍可能会销毁
            ///要实现永不销毁，需page继承AutomaticKeepAlive并将wantKeepAlive设为true（或者将page用KeepAliveWrapper包裹）
            //  allowImplicitScrolling: true,
            physics: const NeverScrollableScrollPhysics(),
          )),
      bottomNavigationBar: BottomBar(onTap: onBottomTabClicked, currentIndex: _currentIndex),
    );
  }

  void _initPages() {
    _keys = [];
    _keys.add(GlobalKey<MainPageState>());
    _keys.add(GlobalKey<MusicPageState>());
    _keys.add(GlobalKey<DiscoveryPageState>());
    _keys.add(GlobalKey<SettingsPageState>());

    _pages = [];
    _pages.add(MainPage(key: _keys[0]));
    _pages.add(MusicPage(key: _keys[1]));
    _pages.add(DiscoveryPage(key: _keys[2]));
    _pages.add(SettingsPage(key: _keys[3]));
  }

  void onBottomTabClicked(int index) {
    LogUtils.d(_tag, "onBottomTabClicked:$index");
    _pageController.jumpToPage(index);
    _currentIndex = index;
    setState(() {});
  }
}