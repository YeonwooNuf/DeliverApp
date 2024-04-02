import 'package:delivery/pages/FavoritePage.dart';
import 'package:delivery/pages/HomePage.dart';
import 'package:delivery/pages/MyPage.dart';
import 'package:delivery/pages/OrderHistoryPage.dart';
import 'package:delivery/widget/bottom_bar.dart';
import 'package:flutter/material.dart';
//test
//김수현
//나혼자해봄
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'title',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        hintColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[ 
              HomePage(),
              FavoritePage(),
              OrderHistoryPage(),
              MyPage(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}