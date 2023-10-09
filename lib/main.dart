import 'dart:async';

import 'package:flutter/material.dart';
import 'package:main/src/main_page.dart';
import 'package:settings/src/settings_page.dart';
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

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  late List<Widget> _pages;
  late List<GlobalKey> _keys;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: PageView(
        children: _pages,
        controller: _pageController,
        //physics: const NeverScrollableScrollPhysics(),
      )),
      bottomNavigationBar: const BottomBar(),
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
    //_keys.add(GlobalKey<MainPageState>());
    //_keys.add(GlobalKey<MainPageState>());
    _keys.add(GlobalKey<SettingsPageState>());

    _pages = [];
    _pages.add(MainPage(key: _keys[0]));
    _pages.add(const Text("Page2", style: TextStyle(color: Colors.red, fontSize: 20)));
    _pages.add(const Text("Page3", style: TextStyle(color: Colors.red, fontSize: 20)));
    _pages.add(SettingsPage(key: _keys[1]));
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
