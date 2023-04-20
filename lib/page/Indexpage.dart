import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mv/page/ClassifyPage.dart';
import 'package:flutter_mv/page/HomePage.dart';
import 'package:flutter_mv/page/MePage.dart';
import 'package:flutter_mv/page/NewsPage.dart';

class IndexPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _IndexStatePage();

}

class _IndexStatePage extends State<IndexPage>{

  int _currentIndex = 0;
  final List<Widget> _childern =[
    HomePage(),
    ClassifyPage(),
    NewsPage(),
    MePage(),
  ];

  void onTabRapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childern[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTabRapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: '分类'),
          BottomNavigationBarItem(icon: Icon(Icons.fiber_new_sharp),label: '新闻'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: '个人'),
        ],
      ),
    );
  }
}