import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    // 기본값 설정
    selectedFilter = filterOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로 가기 버튼 클릭 시 현재 라우트를 제거하여 이전 화면으로 이동
            print("뒤로가기버튼 클릭됨");
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '즐겨찾기',
          style: TextStyle(color: Colors.black), // 텍스트 색상 변경
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // 배경색 변경
        elevation: 0, // 그림자 없애기
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // 양쪽에 16.0 패딩 추가
        child: Column(
          children: [
            // 필터 드롭다운을 오른쪽으로 정렬
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(width: 5), // 아이콘과 텍스트 사이 간격
                            // Icon(Icons.arrow_drop_down, color: Colors.black), // 필터 아이콘
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // ListView를 사용하여 스크롤 가능한 목록 생성
            Expanded(
              child: ListView(
                children: [
                  buildItemWidget(
                    imagePath: 'assets/images/1.png',
                    title: '동대문 엽기떡볶이 인하대점',
                    starRating: 4,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ), // Divider 추가
                  buildItemWidget(
                    imagePath: 'assets/images/2.png',
                    title: '청년다방 인하대점',
                    starRating: 3,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ), // Divider 추가
                  buildItemWidget(
                    imagePath: 'assets/images/3.png',
                    title: '백소정 인하대점',
                    starRating: 5,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ), // Divider 추가
                  buildItemWidget(
                    imagePath: 'assets/images/4.png',
                    title: '더 진국 인하대점',
                    starRating: 2,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ), // Divider 추가
                  buildItemWidget(
                    imagePath: 'assets/images/4.png',
                    title: '더 진국 인하대점',
                    starRating: 4,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ), // Divider 추가
                  buildItemWidget(
                    imagePath: 'assets/images/4.png',
                    title: '더 진국 인하대점',
                    starRating: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Scaffold의 배경색을 흰색으로 변경
    );
  }

  Widget buildItemWidget({required String imagePath, required String title, required int starRating}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 설정
              // border: Border.all(color: Colors.black, width: 1), // 테두리 추가
            ),
            child: ClipRRect( // 모서리를 둥글게 하기 위해 ClipRRect 사용
              borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 설정
              child: Row(
                children: [
                  Image.asset(
                    imagePath,
                    width: 110,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10), // 이미지와 텍스트 사이 간격
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.0,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black, // 텍스트 색상 변경
                          ),
                        ),
                        Row(
                          children: List.generate(starRating, (index) => Icon(Icons.star, color: Colors.yellow, size: 20)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(Icons.close),
              iconSize: 18, // 삭제 버튼 아이콘의 크기 조절
              onPressed: () {
                // 삭제 버튼을 눌렀을 때 팝업 창 표시
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("삭제 확인"),
                      content: Text("정말 삭제하시겠습니까?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            print("삭제 확인");
                            // 삭제 작업 수행
                            // 여기에 삭제 로직을 추가하세요
                            Navigator.of(context).pop(); // 팝업 닫기
                          },
                          child: Text("예"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // 팝업 닫기
                          },
                          child: Text("아니오"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
