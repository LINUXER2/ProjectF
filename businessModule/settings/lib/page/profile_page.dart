import 'package:common/export.dart';
import 'package:common/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  static const String _tag = "ProfilePageState";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    LogUtils.d(_tag, "initState");
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(ProfilePage oldWidget) {
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
    _scrollController.removeListener(_onScroll);
  }

  _onScroll() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContent());
  }

  Widget _buildContent() {
    // return CustomScrollView(controller: _scrollController, slivers: [
    //   _buildAppBar(),
    //   _buildDesc(),
    // ]);
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool scrolled) {
          return [
            _buildAppBar(),
            _buildDesc(),
          ];
        },
        controller: _scrollController,
        body: _buildBody());
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.grey,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      //collapsedHeight:20, // 收缩起来的高度
      expandedHeight: MediaQuery.of(context).size.width,
      // 展开时的高度
      pinned: true,
      // 是否固定
      floating: false,
      //是否漂浮
      snap: false,
      // 当漂浮时，此参数才有效
      forceElevated: true,
      //导航栏下面是否一直显示阴影
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: GestureDetector(
        child: Container(
          alignment: AlignmentDirectional.center,
          child: const Text("about me", style: TextStyle(color: Colors.black, fontSize: 18)),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration:
              const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.settings$assets_images_profile_bg_webp), fit: BoxFit.fitHeight)),
          height: MediaQuery.of(context).size.width,
        ),
      ),
      //bottom: PreferredSize(preferredSize: const Size(0, 0), child: Container(height: 23.0, alignment: Alignment.bottomCenter))
    );
  }

  Widget _buildDesc() {
    return SliverToBoxAdapter(
        child: Container(
      height: 1000,
      color: Colors.amber,
    ));
  }

  Widget _buildBody() {
    return ListView.builder(
        itemCount: 30,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(height: 50, child: Text("第$index条"));
        });
  }
}
