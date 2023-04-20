import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MeSatePage();

}

class _MeSatePage extends State<MePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("个人中心页面"),
    );
  }
}