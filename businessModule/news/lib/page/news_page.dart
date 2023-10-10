import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(alignment: AlignmentDirectional.center, child: const Text("NewsPage", style: TextStyle(color: Colors.red, fontSize: 20)));
  }
}
