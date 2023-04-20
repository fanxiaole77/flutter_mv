import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mv/service/http_config.dart';
import 'package:flutter_mv/service/http_service.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeSatePage();
}

class _HomeSatePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Future.wait([
        get(getHomeBanner),
        get(getHomeType),
        get(getHomeHot,queryParameters: {"hot" : "Y"}),
        get(getHomeNewsType),
        // get(getHomeNews,queryParameters: {"type":""})
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());

            // print("$data");

            List<Map> getHomeBanner = (data[0]['rows'] as List).cast();

            List<Map> getHomeType = (data[1]['rows'] as List).cast();

            List<Map> getHomeHot = (data[2]['rows'] as List).cast();

            List<Map> getHomeNewsType = (data[3]['data'] as List).cast();

            return ListView(
              padding: EdgeInsets.all(8),
              children: [
                SwiperDiy(swiperDateList: getHomeBanner),
                SizedBox(height: 20),
                TopNavigation(nvaiagtionList: getHomeType),

                SizedBox(height: 20,),

                HotNews(hotnewsList: getHomeHot),

                SizedBox(height: 10,),

                TopPageViewDemo(topList: getHomeNewsType),
              ],
            );
          }
        }
        return Center(
          child: Text('aaaaa'),
        );
      },
    ));
  }
}

//*首页轮播图*/

class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  SwiperDiy({Key? key, required this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 350,
      child: Swiper(
        itemCount: swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "$base_url${swiperDateList[index]['advImg']}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//首页分类
class TopNavigation extends StatelessWidget {
  final List nvaiagtionList;

  TopNavigation({Key? key, required this.nvaiagtionList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tempIndex = -1;

    return Container(
      color: Colors.white,
      height: 150,
      padding: EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 5,
        childAspectRatio: 1.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        physics: NeverScrollableScrollPhysics(),
        children: nvaiagtionList.map((item){
          tempIndex++;
          return _gridViewItemUI(context, item, tempIndex);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item, index) {
    if (index == 9) {
      return InkWell(
        onTap: () {},
        child: Column(
          children: [
            Image.network(
              "$base_url${nvaiagtionList[index]['imgUrl']}",
              width: 50,
            ),
            Text(
              "全部服务",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {},
        child: Column(
          children: [
            Image.network(
              "$base_url${nvaiagtionList[index]['imgUrl']}",
              width: 50,
            ),
            Text(
              item['serviceName'],
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      );
    }
  }

}



//热点新闻
class HotNews extends StatelessWidget {
  final List hotnewsList;

  HotNews({Key? key, required this.hotnewsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tempIndex = -1;
    return Container(
      color: Colors.white,
      height: 235,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 20,
        childAspectRatio: 1 / 0.65,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: hotnewsList.map((item){
          tempIndex++;
          return _gridViewItemUI(context, item, tempIndex);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItemUI(BuildContext context, item, index) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "$base_url${hotnewsList[index]['cover']}",
                width: 170,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              item['title'],
              style: TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}


class TopPageViewDemo extends StatefulWidget{

  final List topList;

  TopPageViewDemo({Key? key , required this.topList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TopPageViewDemoState(topList);
}

class TopPageViewDemoState extends State<TopPageViewDemo> with SingleTickerProviderStateMixin{

  final List topList;

  TopPageViewDemoState(this.topList);


  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: topList.length, vsync: this);

    var _tabs = topList.map((item) => Tab(text: item['name'])).toList();

    var _newsList = topList.map((item){
      return FutureBuilder(
        future: Future.wait([
          get(getHomeNews,queryParameters: {"type":"${item['id']}"})
        ]),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              var data = json.decode(snapshot.data.toString());
              List<Map> getHomeNews = (data[0]["rows"] as List).cast();
              print("${getHomeNews.toString()}");

              return ListView.builder(itemBuilder: (context, index) {
                return _item(index,context,getHomeNews);
              },
            );
          //     shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
            }
          }
          return Center(
            child: Text("1111"),
          );
        },
      );

    }).toList();


    return Expanded(
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Container(
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: _tabs,
                  isScrollable: true,
                ),
              ),

              Container(
                width: double.minPositive,
                height: 2000,
                child: TabBarView(
                controller: _tabController,
                children: _newsList,
              ),
              )
            ],
          ),
        )
    );
  }
}

Widget _item(index,context,getHomeNews) {

  return InkWell(
    onTap: (){},
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.grey)
        )
      ),
      child: Row(
        children: [
          Expanded(child:Image.network("${base_url}${getHomeNews[index]['cover']}"))
        ],
      ),
    ),
  );
}
