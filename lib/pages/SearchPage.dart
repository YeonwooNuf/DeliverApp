import 'package:flutter/material.dart';
import 'package:delivery/pages/SearchedPage.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController(); // TextEditingController 생성

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '검색',
          style: TextStyle(
            color: Colors.black,
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController, // TextEditingController 연결
                    decoration: InputDecoration(
                      hintText: '검색어를 입력하세요',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // 버튼과 텍스트 필드 사이 간격 조절
                ElevatedButton(
                  onPressed: () {
                    String keyword = _searchController.text; // 검색어를 가져옴
                    Navigator.push( // 다음 페이지로 이동
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchedPage(keyword: keyword), // 검색어를 전달
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // 파란색 배경
                  ),
                  child: Text(
                    '검색',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ), // 버튼 텍스트
                ),
              ],
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
                    color: Colors.black,
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
                      fontSize: 16,
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
                      Icon(Icons.access_time, color: Colors.grey, size: 16),
                      SizedBox(width: 10),
                      Text('청년다방', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black, size: 16),
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
                      Icon(Icons.access_time, color: Colors.grey, size: 16),
                      SizedBox(width: 10),
                      Text('동대문 엽기떡볶이', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black, size: 16),
                  onPressed: () {
                    // X 버튼 기능 구현
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
