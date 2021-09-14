import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviesapi/screen/Latestpage.dart';
import 'package:moviesapi/screen/categorypost.dart';
import 'package:moviesapi/screen/drawer.dart';
import 'package:moviesapi/screen/photos.dart';
import 'package:moviesapi/screen/videos.dart';

class MainTab extends StatefulWidget {
  MainTab({Key? key}) : super(key: key);

  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<Tab> topTabs = <Tab>[
    Tab(child: Text("Latest")),
    Tab(child: Text("POPULAR")),
    Tab(child: Text("VIDEOS")),
    Tab(child: Text("PHOTOS")),
    Tab(child: Text("VIDEOS")),
  ];

  @override
  void initState() {
    _tabController =
        TabController(length: topTabs.length, initialIndex: 0, vsync: this)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    print("on Will Pop");
    if (_tabController?.index == 0) {
      await SystemNavigator.pop();
    }
    Future.delayed(Duration(microseconds: 200), () {
      print("set state");
      _tabController?.index = 0;
    });
    print("return");
    return _tabController?.index == 0;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "BLOG",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: [
              Padding(padding: EdgeInsets.all(15)),
              Container(
                child: IconButton(
                  icon: Icon(CupertinoIcons.search),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    print("Search press");
                  },
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orangeAccent[300],
                ),
              ),
              Container(
                  child: IconButton(
                icon: Icon(
                  CupertinoIcons.line_horizontal_3,
                ),
                onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
              ))
            ],
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: topTabs,
              controller: _tabController,
              indicatorColor: Colors.white,
            ),
          ),
          endDrawer: Container(
            child: MyDrawer(),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              LatestPage(),
              CategoryPage(),
              Videos(),
              Photos(),
              Text("jay")
            ],
          ),
        ),
      ),
    );
  }
}
