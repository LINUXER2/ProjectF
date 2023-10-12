import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key, this.label = 'loading...', this.progress, this.color}) : super(key: key);

  final String? label;
  final double? progress;
  final Color? color;

  @override
  _LoadingState createState() => _LoadingState(label: label, progress: progress, color: color);
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  final String? label;
  final double? progress;
  final Color? color;
  AnimationController? _controller;

  _LoadingState({this.label = "", this.progress = 0, this.color = Colors.white});

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(value: progress, strokeWidth: 3.0, valueColor: AlwaysStoppedAnimation(color ?? Colors.blueGrey)),
    );
  }
}
