import 'package:flutter/material.dart';
import 'SearchPage.dart'; // SearchPage.dart 파일을 import 합니다.

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _appBar(context), // _appBar에 context를 전달합니다.
          _contents(context), // _contents에 context를 전달합니다.
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search, color: Colors.black), // 돋보기 아이콘 추가
                  Text(
                    '집 주소',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Expanded(child: Container(height: 50)),
                ],
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
                        onTap: () {
                          // 검색 필드를 탭했을 때 SearchPage로 이동합니다.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SearchPage()),
                          );
                        },
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

  Widget _contents(BuildContext context) {
    // 내용 위젯을 반환합니다.
    return Expanded(
      child: SingleChildScrollView(
        child: Container( // 배경색을 흰색으로 설정한 Container를 추가합니다.
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  _roundedContainer(context, 'assets/images/bibimbap.jpeg', '한식'),
                  SizedBox(width: 8),
                  _roundedContainer(context, 'assets/images/sushi.jpeg', '일식'),
                  SizedBox(width: 8),
                  _roundedContainer(context, 'assets/images/jjajang.jpeg', '중식'),
                  SizedBox(width: 8),
                  _roundedContainer(context, 'assets/images/chicken.jpeg', '치킨'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _roundedContainer(context, 'assets/images/pizza.jpeg', '피자'),
                  SizedBox(width: 8),
                  _roundedContainer(context, 'assets/images/pho.jpeg', '아시아'),
                  SizedBox(width: 8),
                  _roundedContainer(context, 'assets/images/burrito.jpeg', '멕시칸'),
                  SizedBox(width: 8),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roundedContainer(BuildContext context, String image, String title) {
    double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white, // 배경색을 흰색으로 설정
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
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
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}