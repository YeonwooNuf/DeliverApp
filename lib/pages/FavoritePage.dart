import 'package:delivery/AddressChange.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(home: FavoritePage()));

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // 필터링 옵션을 문자열 리스트로 정의
  final List<String> filterOptions = ['최근 추가한 순', '최근 주문한 순', '자주 주문한 순'];

  // 현재 선택된 필터링 옵션
  String? selectedFilter;

  // 즐겨찾기 목록을 저장할 리스트
  List<Widget> favorites = [];

  // 즐겨찾기 항목 데이터
  final List<Map<String, dynamic>> favoriteData = [
    {
      'imagePath': 'assets/images/1.png',
      'title': '동대문 엽기떡볶이 인하대점',
      'starRating': 4,
    },
    {
      'imagePath': 'assets/images/2.png',
      'title': '청년다방 인하대점',
      'starRating': 3,
    },
    {
      'imagePath': 'assets/images/3.png',
      'title': '백소정 인하대점',
      'starRating': 5,
    },
  ];

  int currentIndex = 0; // 다음에 추가할 즐겨찾기 항목의 인덱스

  @override
  void initState() {
    super.initState();
    // 기본값 설정
    selectedFilter = filterOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton( // 뒤로가기 버튼 제거
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // 뒤로 가기 버튼 클릭 시 현재 라우트를 제거하여 이전 화면으로 이동
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text(
          '즐겨찾기',
          style: TextStyle(color: Colors.black), // 텍스트 색상 변경
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // 배경색 변경
        elevation: 0, // 그림자 없애기
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // 양쪽에 상대적인 패딩 추가
        child: Column(
          children: [
            // 필터 드롭다운을 오른쪽으로 정렬
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
                children: [
                  DropdownButton<String>(
                    value: selectedFilter,
                    underline: Container(),
                    dropdownColor: Colors.white, // 드롭다운 메뉴 배경색 흰색으로 변경
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black), // 드롭다운 버튼의 아이콘 설정
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue;
                      });
                    },
                    items: filterOptions.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Text(
                              value,
                              style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04),
                            ),
                            SizedBox(width: screenWidth * 0.01), // 아이콘과 텍스트 사이 간격
                            // Icon(Icons.arrow_drop_down, color: Colors.black), // 필터 아이콘
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // 즐겨찾기 추가 버튼
            ElevatedButton(
              onPressed: () {
                // 다음 항목을 가져와서 즐겨찾기에 추가
                addFavoriteItem(
                  favoriteData[currentIndex]['imagePath'],
                  favoriteData[currentIndex]['title'],
                  favoriteData[currentIndex]['starRating'].toString(),
                );

                // 다음 항목의 인덱스 업데이트
                currentIndex = (currentIndex + 1) % favoriteData.length;
              },
              child: Text('즐겨찾기 추가'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // 버튼의 배경색을 파란색으로 변경
                textStyle: TextStyle(fontSize: screenWidth * 0.04), // 버튼 텍스트 크기 조정
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
            // ListView를 사용하여 스크롤 가능한 목록 생성
            Expanded(
              child: ListView(
                children: [
                  // 즐겨찾기 목록
                  ...favorites,
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Scaffold의 배경색을 흰색으로 변경
    );
  }

  // 즐겨찾기 항목을 생성하고 리스트에 추가하는 함수
  void addFavoriteItem(String imagePath, String title, String starRating) {
    setState(() {
      favorites.add(
        buildItemWidget(imagePath, title, starRating),
      );
    });
  }

  // 즐겨찾기 항목 위젯 생성 함수
  Widget buildItemWidget(String imagePath, String title, String starRating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200], // 배경색을 회색 계통으로 변경
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Image.asset(
                    imagePath,
                    width: 110,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: List.generate(
                            int.parse(starRating),
                            (index) => Icon(Icons.star, color: Colors.yellow, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
