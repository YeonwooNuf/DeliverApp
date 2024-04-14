import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(16),
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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '최근 검색어',
                  style: TextStyle(
                    fontSize: 18,
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
                      fontSize: 16, // '전체 삭제' 텍스트 크기를 16으로 설정
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, color: Colors.grey, size: 16), // 시계 아이콘 색상을 회색으로, 크기를 16으로 설정
                      SizedBox(width: 10),
                      Text('청년다방', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)), // '청년다방' 텍스트 크기를 16으로, 볼드 스타일로 설정
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black, size: 16), // X 버튼 색상을 검정색으로, 크기를 16으로 설정
                  onPressed: () {
                    // X 버튼 기능 구현
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, color: Colors.grey, size: 16), // 시계 아이콘 색상을 회색으로, 크기를 16으로 설정
                      SizedBox(width: 10),
                      Text('동대문 엽기떡볶이', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)), // '청년다방' 텍스트 크기를 16으로, 볼드 스타일로 설정
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black, size: 16), // X 버튼 색상을 검정색으로, 크기를 16으로 설정
                  onPressed: () {
                    // X 버튼 기능 구현
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