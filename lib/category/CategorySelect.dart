import 'package:delivery/pages/MenuSearchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategorySelect extends StatefulWidget {
  final String CategoryName;
  CategorySelect({required this.CategoryName});

  @override
  _JapaneseState createState() => _JapaneseState();
}

class _JapaneseState extends State<CategorySelect> {
  var currentValue = '1'; //드롭다운메뉴 변수
  final List<String> _items = <String>['가나다순', '신규매장순']; //드롭다운메뉴
  late String selectedValue = _items[0];
  final List<String> _titles = ["한식", "일식", "중식", "치킨", "피자", "아시아", "멕시칸"];
  late int _currentIndex; //초기탭 배열번호 선언
  bool IsFilled = false;

  @override
  void initState() {
    super.initState();
    _currentIndex =
        _titles.indexOf(widget.CategoryName); // initState 메서드 내에서 호출
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      initialIndex: _currentIndex, // 초기 탭
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(
              _titles[_currentIndex], //탭을 누를때마다 타이틀 변경되게 함.
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.black),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60), // 탭바 높이 + 추가 컨테이너 높이
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: "한식"),
                    Tab(text: "일식"),
                    Tab(text: "중식"),
                    Tab(text: "치킨"),
                    Tab(text: "피자"),
                    Tab(text: "아시아"),
                    Tab(text: "멕시칸"),
                  ],
                  indicatorColor: Colors.grey, // 여기서 선의 색상을 설정합니다
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Row를 오른쪽 정렬합니다
                    children: [_Filter()],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              //한식페이지
              child: Column(
                children: [
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                ],
              ),
            ),
            SingleChildScrollView(
              //일식페이지
              child: Column(
                children: [
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                ],
              ),
            ),
            SingleChildScrollView(
              //중식페이지
              child: Column(
                children: [
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                ],
              ),
            ),
            SingleChildScrollView(
              //치킨페이지
              child: Column(
                children: [
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                ],
              ),
            ),
            SingleChildScrollView(
              //피자페이지
              child: Column(
                children: [
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                ],
              ),
            ),
            SingleChildScrollView(
              //아시아페이지
              child: Column(
                children: [
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                ],
              ),
            ),
            SingleChildScrollView(
              //멕시칸페이지
              child: Column(
                children: [
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                  _Image('assets/images/sushi.jpeg', '초밥집'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//맨위에 있는 필터 메서드
  Widget _Filter() {
    return Container(
      height: 30,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // 테두리 색상
          width: 1.0, // 테두리 두께
        ),
        borderRadius: BorderRadius.circular(30), // 테두리 모양 (원형)
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        iconSize: 24,
        style: const TextStyle(color: Colors.black),
        underline: Container(), // 밑줄 감추기
        dropdownColor: Colors.white,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: _items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  //이미지 클릭 메서드
  Widget _Image(String image_URL, String storeName) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuSearchPage(
                              image_URL: image_URL,
                              storeName: storeName,
                            )),
                  );
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // 원하는 반지름 값으로 설정
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // 원하는 반지름 값으로 설정
                    child: Image.asset(
                      '${image_URL}',
                      fit: BoxFit.fill, // 이미지를 컨테이너에 맞춤
                      width: double.infinity, // 이미지가 컨테이너에 가득 차도록 가로 너비를 확장
                      height: double.infinity, // 이미지가 컨테이너에 가득 차도록 세로 너비를 확장
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: HeartIconButton(),
              ),
            ],
          ),
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            child: Text(
              '${storeName}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//하트아이콘 기능 정의
class HeartIconButton extends StatefulWidget {
  @override
  _HeartIconButtonState createState() => _HeartIconButtonState();
}

class _HeartIconButtonState extends State<HeartIconButton> {
  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isFilled
          ? Icon(Icons.favorite, color: Colors.red)
          : Icon(Icons.favorite_border, color: Colors.white),
      onPressed: () {
        setState(() {
          isFilled = !isFilled;
        });
      },
    );
  }
}