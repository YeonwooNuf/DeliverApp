import 'package:flutter/material.dart';
import 'package:delivery/pages/address/AddressSearch.dart';
import 'package:delivery/pages/address/AddressMapPage.dart'; // AddressMap import

class NewAddressPage extends StatefulWidget {
  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.9; // 버튼의 크기 = 화면넓이의 90%
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('새 주소 추가')), // 주소 등록 페이지 제목 추가
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20), // 상단 간격 조정
            TextField(
              onTap: () {
                // 도로명, 건물 또는 지번으로 검색 기능 구현
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressSearch()),
                );
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), // 돋보기 아이콘 추가
                hintText: '도로명, 건물 또는 지번으로 검색',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700, // FontWeight 추가
                ),
              ),
            ), 
            SizedBox(height: 20), // 검색창 아래 간격 조정
            SizedBox(
              width: buttonWidth, // 버튼 넓이 지정
              child: ElevatedButton.icon(
                onPressed: () {
                  // 현재 위치로 주소 찾기 기능 구현
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddressMapPage()),
                  );
                },
                icon: Icon(Icons.my_location), // 현재 위치 아이콘 추가
                label: Text('현재 위치로 주소 찾기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 230, 242, 255),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20), // 버튼과 Divider 간격 조정
            Divider(height: 1, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
