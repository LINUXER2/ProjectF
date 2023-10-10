import 'dart:async';

import 'package:common/utils/system_utils.dart';
import 'package:discovery/page/discovery_page.dart';
import 'package:flutter/material.dart';
import 'package:main/page/main_page.dart';
import 'package:news/page/news_page.dart';
import 'package:settings/page/settings_page.dart';
import 'package:projectf/bottom_bar.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    runApp(const MyApp());
  }, (error, stackTrace) async {
    print("$error,$stackTrace");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    print("jinn2.screen test:width:${System.width},height:${System.height},statusHeight:${System.statusHeight},ratio:${System.devicePixelRatio}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: PageView(
        children: _pages,
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
      )),
      bottomNavigationBar: BottomBar(onTap: onBottomTabClicked, currentIndex: _currentIndex),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initPages();
  }

  void _initPages() {
    _keys = [];
    _keys.add(GlobalKey<MainPageState>());
    _keys.add(GlobalKey<NewsPageState>());
    _keys.add(GlobalKey<DiscoveryPageState>());
    _keys.add(GlobalKey<SettingsPageState>());

    _pages = [];
    _pages.add(MainPage(key: _keys[0]));
    _pages.add(NewsPage(key: _keys[1]));
    _pages.add(DiscoveryPage(key: _keys[2]));
    _pages.add(SettingsPage(key: _keys[3]));
  }

  void onBottomTabClicked(int index) {
    print("onBottomTabClicked:$index");
    _pageController.jumpToPage(index);
    _currentIndex = index;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
}
