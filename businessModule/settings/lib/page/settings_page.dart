import 'package:common/utils/log_utils.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin {
  static const String _tag = "SettingsPageState";

  @override
  void initState() {
    super.initState();
    LogUtils.d(_tag, "initState");
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(alignment: AlignmentDirectional.center, child: const Text("SettingsPage", style: TextStyle(color: Colors.red, fontSize: 20)));
  }

  @override
  bool get wantKeepAlive => true;
}
