import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black, // 뒤로 가기 버튼 색상을 검정색으로 설정
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기 버튼을 눌렀을 때 이전 화면으로 이동
          },
        ),
        title: Text(
          '검색',
          style: TextStyle(
            color: Colors.black, // 제목 텍스트 색상을 검정색으로 설정
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black, // 돋보기 아이콘 색상을 검정색으로 설정
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(screenWidth * 0.03), // 텍스트 필드의 모서리를 둥글게 만듭니다.
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.04), // 위젯 사이의 간격 조정
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '최근 검색어',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 텍스트 크기를 화면 너비의 4%로 설정
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // '최근 검색어' 텍스트 색상을 검정색으로 설정
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // 전체 삭제 기능 추가
                  },
                  child: Text(
                    '전체 삭제',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: screenWidth * 0.035, // '전체 삭제' 텍스트 크기를 화면 너비의 3.5%로 설정
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.02), // 위젯 사이의 간격 조정
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // "청년다방"이 선택되었을 때 실행될 코드
                      print('청년다방이 탭되었습니다.');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.015), // 적당한 패딩을 추가하여 탭하기 쉽게 만듭니다.
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time, color: Colors.grey, size: screenWidth * 0.032), // 시계 아이콘 색상을 회색으로, 크기를 화면 너비의 3.2%로 설정
                          SizedBox(width: screenWidth * 0.02), // 아이콘과 텍스트 사이의 간격 조정
                          Text('청년다방', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)), // 텍스트 크기를 화면 너비의 4%로 설정, 볼드 스타일로 설정
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black, size: screenWidth * 0.032), // X 버튼 색상을 검정색으로, 크기를 화면 너비의 3.2%로 설정
                  onPressed: () {
                    // X 버튼이 눌렸을 때 실행될 코드
                    print('X 버튼이 탭되었습니다.');
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // "동대문 엽기떡볶이"가 선택되었을 때 실행될 코드
                      print('동대문 엽기떡볶이가 탭되었습니다.');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.015), // 탭하기 쉽게 하기 위해 적당한 패딩을 추가합니다.
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time, color: Colors.grey, size: screenWidth * 0.032), // 시계 아이콘 색상을 회색으로, 크기를 화면 너비의 3.2%로 설정
                          SizedBox(width: screenWidth * 0.02), // 아이콘과 텍스트 사이의 간격 조정
                          Text('동대문 엽기떡볶이', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)), // 텍스트 크기를 화면 너비의 4%로 설정, 볼드 스타일로 설정
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black, size: screenWidth * 0.032), // X 버튼 색상을 검정색으로, 크기를 화면 너비의 3.2%로 설정
                  onPressed: () {
                    // X 버튼이 눌렸을 때 실행될 코드
                    print('X 버튼이 탭되었습니다.');
                  },
                ),
              ],
            ),
            // 여기에 추가적인 위젯을 배치할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
