import 'package:flutter/material.dart';


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
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: '검색',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 20),
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

   Widget _roundedContainer(String image, String title) {
  double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
  return Expanded(
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30), // 컨테이너의 모서리를 둥글게 설정
          ),
          width: squareSize,
          height: 50,
          child: ClipRRect( // 이미지의 모서리만 둥글게 하기 위해 ClipRRect를 사용합니다.
            borderRadius: BorderRadius.circular(30), // 이미지의 모서리를 둥글게 설정
            child: Image.asset(
              image,
              width: squareSize,
              height: 50,
              fit: BoxFit.cover, // 이미지가 컨테이너에 꽉 차도록 설정
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
                        _roundedContainer('assets/images/bibimbap.jpeg', '한식'),
                        SizedBox(
                          width: 8,
                        ),
                        _roundedContainer('assets/images/sushi.jpeg', '일식'),
                        SizedBox(
                          width: 8,
                        ),
                        _roundedContainer('assets/images/jjajang.jpeg', '중식'),
                        SizedBox(
                          width: 8,
                        ),
                       _roundedContainer('assets/images/chicken.jpeg', '치킨'),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        _roundedContainer('assets/images/pizza.jpeg', '피자'),
                        SizedBox(
                          width: 8,
                        ),
                        _roundedContainer('assets/images/pho.jpeg', '아시아'),
                        SizedBox(
                          width: 8,
                        ),
                       _roundedContainer('assets/images/burrito.jpeg', '멕시칸'),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
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
