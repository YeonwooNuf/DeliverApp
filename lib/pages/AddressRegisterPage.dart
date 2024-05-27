import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/AddressChange.dart';
import 'package:delivery/pages/AddressSearch.dart';
import 'package:delivery/pages/AddressMapPage.dart';

class AddressRegisterPage extends StatefulWidget {
  
  @override
  _AddressRegisterPageState createState() => _AddressRegisterPageState();
}

class _AddressRegisterPageState extends State<AddressRegisterPage> {
  int _selectedIndex = -2;

  @override
  Widget build(BuildContext context) {
    double buttonWidth =
        MediaQuery.of(context).size.width * 0.9; //버튼의 크기 = 화면넓이의 90%
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('주소 등록')), // 주소 등록 페이지 제목 추가
      ),
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20), // 상단 간격 조정
            TextField(
              onTap: () {
                // 도로명, 건물 또는 지번으로 검색 기능 구현
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressSearch()),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  }
                });
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddressMapPage()),
                  );
                },
                icon: Icon(Icons.my_location), // 현재 위치 아이콘 추가
                label: Text('현재 위치로 주소 찾기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 245, 245, 100),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20), // 버튼과 Divider 간격 조정
            Divider(height: 1, color: Colors.grey),
            Expanded(
              child: _buildAddressList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressList(BuildContext context) {

    // 주소 목록을 가져오는 예시 함수
    String? homeAddress = Provider.of<ItemListNotifier>(context).homeAddress;
    String? workAddress = Provider.of<ItemListNotifier>(context).workAddress;
    List<String> addresses = Provider.of<ItemListNotifier>(context).addresses;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20), // 주소 목록 위 간격 조정
        Text(
          '    집',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(homeAddress ?? '집 주소가 없습니다.'),
          trailing: _selectedIndex == -2
              ? Icon(Icons.check_circle, color: Colors.blue)
              : null, // _selectedIndex 값이 -2이면 check 아이콘 표시
          onTap: () {
            setState(() {
              _selectedIndex = -2; // 집 주소 선택을 나타내는 값으로 변경
            });
          },
        ),
        SizedBox(height: 10), // 주소 목록과 간격 조정
        Text(
          '    회사',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        ListTile(
          leading: Icon(Icons.work),
          title: Text(workAddress ?? '회사 주소가 없습니다.'),
          trailing: _selectedIndex == -1
              ? Icon(Icons.check_circle, color: Colors.blue)
              : null, // _selectedIndex 값이 -1이면 check 아이콘 표시
          onTap: () {
            setState(() {
              _selectedIndex = -1; // 회사 주소 선택을 나타내는 값으로 변경
            });
          },
        ),
        SizedBox(height: 10), // 주소 목록 아래 간격 조정
        //Divider(height: 1, color: Colors.grey),
        //SizedBox(height: 20), // Divider와 주소 목록 사이 간격 조정
        Text(
          '    기타',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Consumer<ItemListNotifier>(
          builder: (context, itemListNotifier, child) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(addresses[index]),
                  trailing: _selectedIndex == index
                      ? Icon(Icons.check_circle, color: Colors.blue)
                      : null, // 선택한 주소에만 check 아이콘 표시
                  onTap: () {
                    setState(() {
                      _selectedIndex =
                          index; // 선택한 주소의 인덱스로 _selectedIndex 값 변경
                    });
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}