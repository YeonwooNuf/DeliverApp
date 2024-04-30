// AddressSearch.dart
import 'package:flutter/material.dart';
import 'package:delivery/pages/AddressInfo.dart';

class AddressSearch extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

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
          '주소 검색',
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
            TextField(
              controller: _searchController,
              onSubmitted: (value) {
                // 검색된 주소를 AddressInfo 페이지로 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressInfo(searchedAddress: value), // 생성자를 통해 검색된 주소 전달
                  ),
                );
              },
              decoration: InputDecoration(
                hintText: '도로명, 건물명 또는 지번으로 검색하세요',
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
            SizedBox(height: 20),
            Divider(height: 5, color: Colors.grey),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '검색 Tip :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '1. 정확한 도로명 또는 건물명(번호)을 입력하세요.\n'
                '2. 지번 주소를 사용할 경우, 시, 구, 동까지 입력해 주세요.\n'
                '3. 동/읍/면/리 + 번지 수를 같이 입력해주세요.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
