import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/pages/AddressManagePage.dart';
import 'package:delivery/AddressChange.dart';
import 'package:delivery/main.dart';

class CompanyAddressPage extends StatefulWidget {
  @override
  _CompanyAddressPage createState() => _CompanyAddressPage();
}

class _CompanyAddressPage extends State<CompanyAddressPage> {
  // List<String> addresses = [
  //   '인하대,인하공전,정석항공고 인천광역시 미추홀구 인하로 100 수준원점',
  //   '인천광역시 미추홀구 인하로105번길 43 302호',
  // ];
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.9; //버튼의 크기 = 화면넓이의 90%
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('회사 주소 등록')), // 주소 등록 페이지 제목 추가
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // 저장 기능 구현
            },
          ),
        ],
      ),
      
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20), // 상단 간격 조정
            TextField(
              onTap: () {
                // 도로명, 건물 또는 지번으로 검색 기능 구현
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), // 돋보기 아이콘 추가
                hintText: '도로명, 건물 또는 지번으로 검색',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ), 
            SizedBox(height: 20), // 검색창 아래 간격 조정
            SizedBox(
              width: buttonWidth, // 버튼 넓이 지정
              child: ElevatedButton.icon(
                onPressed: () {
                  // 현재 위치로 주소 찾기 기능 구현
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
