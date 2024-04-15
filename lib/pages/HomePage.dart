import 'package:flutter/material.dart';
import 'package:delivery/category/Asian.dart';
import 'package:delivery/category/Chicken.dart';
import 'package:delivery/category/Chinese.dart';
import 'package:delivery/category/Japanese.dart';
import 'package:delivery/category/Korean.dart';
import 'package:delivery/category/Mexican.dart';
import 'package:delivery/category/Pizza.dart';
import 'AddressRegisterPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      home: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _appBar() {
      return SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(left: 16.0), // 좌측에 여백 추가
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddressRegisterPage()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Row의 크기를 내용물에 맞게 조정
                    children: [
                      Icon(Icons.location_on, color: Colors.black),
                      SizedBox(width: 8), // 아이콘과 텍스트 사이에 간격 추가
                      Text(
                        '집 주소',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: '검색',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _roundedContainer(String image, String title, VoidCallback onTap) {
      double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                width: squareSize,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    image,
                    width: squareSize,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _contents() {
      double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
      return Expanded(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _roundedContainer('assets/images/bibimbap.jpeg', '한식', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Korean()),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/sushi.jpeg', '일식', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Japanese()),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/jjajang.jpeg', '중식', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Chinese()),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/chicken.jpeg', '치킨', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Chicken()),
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _roundedContainer('assets/images/pizza.jpeg', '피자', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Pizza()),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/pho.jpeg', '아시아', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Asian()),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/burrito.jpeg', '멕시칸', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Mexican()),
                            );
                          }),
                          SizedBox(width: 8),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          _contents(),
        ],
      ),
    );
  }
}
