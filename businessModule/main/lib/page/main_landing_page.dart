import 'package:common/base/base_screen.dart';
import 'package:flutter/cupertino.dart';

class MainLandingPage extends StatefulWidget {
  const MainLandingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainLandingPageState();
}

class MainLandingPageState extends State<MainLandingPage> with BaseScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    return buildContent();
  }

  @override
  Widget buildContent() {
    return const Center(child: Text("newsLanding"));
  }
}
