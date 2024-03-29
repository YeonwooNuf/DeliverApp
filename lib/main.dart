import 'package:flutter/material.dart';
import 'package:delivery/widget/bottom_bar.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '타이틀',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드로 인한 화면 크기 조정 방지
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
    // 수정된 부분: _appBar 함수 내부에 검색창이 포함된 Container를 추가함
    Widget _appBar() {
      return SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '집 주소',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  Expanded(child: Container(height: 50)),
                ],
              ),
              // 수정된 부분: 검색창이 AppBar 아래에 추가됨
              Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '검색',
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

    Widget _contents() {
      return Expanded(
        child: Container(
          color: Colors.red,
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          _contents(),
          Bottom(), // Bottom() 위젯 추가
        ],
      ),
    );
  }
}