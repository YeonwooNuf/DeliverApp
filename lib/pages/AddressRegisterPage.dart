import 'package:flutter/material.dart';

class AddressRegisterPage extends StatefulWidget {
  @override
  _AddressRegisterPageState createState() => _AddressRegisterPageState();
}

class _AddressRegisterPageState extends State<AddressRegisterPage> {
  List<String> addresses = [
    '인하대,인하공전,경서성공고 인천광역시 미추홀구 인하로 100 수준원점',
    '인천광역시 미추홀구 인하로105번길 43 302호',
  ];
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('주소 등록')), // 주소 등록 페이지 제목 추가
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            ElevatedButton.icon(
              onPressed: () {
                // 현재 위치로 주소 찾기 기능 구현
              },
              icon: Icon(Icons.my_location), // 현재 위치 아이콘 추가
              label: Text('현재 위치로 주소 찾기'),
            ),
            SizedBox(height: 20), // 버튼과 Divider 간격 조정
            Divider(height: 1, color: Colors.grey),
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(addresses[index]),
                    trailing: _selectedIndex == index
                        ? Icon(Icons.check_circle, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
