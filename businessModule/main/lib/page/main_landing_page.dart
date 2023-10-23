import 'package:common/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:main/controller/LandingPageController.dart';

class MainLandingPage extends StatelessWidget {
  MainLandingPage({Key? key}) : super(key: key);
  static const String _tag = "MainLandingPage";
  final LandingPageController _controller = Get.put<LandingPageController>(LandingPageController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(body: _buildContent()),
    );
  }

  Widget _buildContent() {
    LogUtils.d(_tag, "buildContent");
    return GetBuilder<LandingPageController>(builder: (_) {
      return Column(
        children: [
          SizedBox(height: System.statusHeight),
          GetBuilder<LandingPageController>(
              id: LandingPageController.ID_TOP,
              builder: (_) {
                return _buildTop();
              }),
          _buildMiddle(),
          GetBuilder<LandingPageController>(
              id: LandingPageController.ID_BOTTOM,
              builder: (_) {
                return _buildBottom();
              }),
        ],
      );
    });
  }

  Widget _buildTop() {
    LogUtils.d(_tag, "_buildTop");
    return TextButton(
        onPressed: () {
          LandingPageController.num++;
          _controller.updateTop();
        },
        child: Text("${LandingPageController.num}"));
  }

  Widget _buildMiddle() {
    LogUtils.d(_tag, "_buildMiddle");
    return TextButton(
        onPressed: () {
          LandingPageController.num++;
          _controller.updateAll();
        },
        child: Text("${LandingPageController.num}"));
  }

  Widget _buildBottom() {
    LogUtils.d(_tag, "_buildBottom");
    return TextButton(
        onPressed: () {
          LandingPageController.num++;
          _controller.updateBottom();
        },
        child: Text("${LandingPageController.num}"));
  }
}
