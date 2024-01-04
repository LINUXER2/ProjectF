import 'dart:math';

import 'package:common/export.dart';
import 'package:common/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin {
  static const String _tag = "SettingsPageState";
  final ValueNotifier<double> _opacity = ValueNotifier(0.0);
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    LogUtils.d(_tag, "initState");
    _scrollController = ScrollController();
    _scrollController?.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(SettingsPage oldWidget) {
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
    _scrollController?.removeListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(alignment: AlignmentDirectional.center, child: _buildContent());
  }

  Widget _buildContent() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: [
            _buildBody(),
            ValueListenableBuilder<double>(
                valueListenable: _opacity,
                builder: (context, value, child) {
                  return _buildAppBar();
                })
          ],
        ));
  }

  Widget _buildBody() {
    /// CustomScrollView,组合多个list，使其能自然滚动，child必须是sliver
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8, end: 8, top: 60),
            child: Column(
              children: [_buildUserInfo(), _buildFunctions()],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUserInfo() {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadiusDirectional.circular(12)),
    );
  }

  Widget _buildFunctions() {
    return Container(
      height: 1000,
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 60,
      padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
      alignment: AlignmentDirectional.center,
      color: Colors.blueGrey.withOpacity(_opacity.value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back_ios_new),
          const Text("About Me", style: TextStyle(color: Colors.black, fontSize: 18)),
          GestureDetector(
              child: const Icon(Icons.settings),
              onTap: () {
                Get.toNamed("/profilePage", parameters: {});
              }),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _onScroll() {
    if (_scrollController?.hasClients == false || _scrollController?.position == null) {
      return;
    }
    double r = _scrollController!.offset / 150;
    r = max(0, min(r, 1));
    _opacity.value = r;
    LogUtils.d(_tag, "_onScroll,offset:${_scrollController?.offset},opacity:$r");
  }
}
