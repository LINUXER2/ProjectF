import 'package:flutter/material.dart';

import '../widgets/loading_widget.dart';

enum ScreenStatus { Loading, Error, Empty, Ready }

abstract class BaseScreenState<T extends StatefulWidget> extends State<T> with BaseScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar() ?? _buildAppBar(),
      backgroundColor: getBgColor(),
      body: buildStatusContent(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}

mixin BaseScreenStateMixin<T extends StatefulWidget> on State<T> {
  ScreenStatus screenStatus = ScreenStatus.Loading;
  String? emptyMsg;
  Color? emptyMsgColor;
  String? emptyImgPath;
  String? errorMsg;
  Color? errorMsgColor;
  String? errorImgPath;

  bool handleEmptyTap = false;
  bool handleErrorTap = true;

  Widget buildStatusContent() {
    Widget screenWidget = Container();

    switch (screenStatus) {
      case ScreenStatus.Loading:
        screenWidget = const Center(
          child: Loading(),
        );
        break;
      case ScreenStatus.Empty:
        screenWidget = buildEmptyWidget();
        break;
      case ScreenStatus.Error:
        screenWidget = buildErrorWidget();
        break;
      case ScreenStatus.Ready:
        screenWidget = buildContent();
        break;
      default:
        screenWidget = buildContent();
    }
    return screenWidget;
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      child: Container(),
      preferredSize: const Size.fromHeight(44),
    );
  }

  Widget buildEmptyWidget() {
    return GestureDetector(
      child: const Text("no data,please retry"),
      onTap: () {
        if (handleEmptyTap) {
          setScreenLoading();
          onTapEmptyWidget();
        }
      },
    );
  }

  Widget buildErrorWidget() {
    return GestureDetector(
      child: const Text("error,please retry"),
      onTap: () {
        if (handleEmptyTap) {
          setScreenLoading();
          onTapEmptyWidget();
        }
      },
    );
  }

  @protected
  PreferredSizeWidget? buildAppBar() {
    return null;
  }

  Widget? buildBottomNavigationBar() {
    return null;
  }

  Color getBgColor() {
    return Colors.white;
  }

  @protected
  Widget buildContent();

  @protected
  void onTapErrorWidget() {}

  @protected
  void onTapEmptyWidget() {}

  setScreenError({String? errorMsg, String? errorImgPath, bool handleErrorTap = true, Color? errorMsgColor}) {
    screenStatus = ScreenStatus.Error;
    this.errorMsg = errorMsg;
    this.errorImgPath = errorImgPath;
    this.handleErrorTap = handleErrorTap;
    this.errorMsgColor = errorMsgColor;
    if (mounted) setState(() {});
  }

  setScreenEmpty({String? emptyMsg, bool handleEmptyTap = false, Color? emptyMsgColor, String? emptyImgPath}) {
    screenStatus = ScreenStatus.Empty;
    this.handleEmptyTap = handleEmptyTap;
    this.emptyMsg = emptyMsg;
    this.emptyMsgColor = emptyMsgColor;
    this.emptyImgPath = emptyImgPath;
    if (mounted) setState(() {});
  }

  setScreenLoading() {
    screenStatus = ScreenStatus.Loading;
    if (mounted) setState(() {});
  }

  setScreenReady() {
    screenStatus = ScreenStatus.Ready;
    if (mounted) setState(() {});
  }

  bool isScreenReady() {
    return screenStatus == ScreenStatus.Ready;
  }
}
