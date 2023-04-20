import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _NewsSatePage();

}

class _NewsSatePage extends State<NewsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("新闻页面"),
    );
  }
}