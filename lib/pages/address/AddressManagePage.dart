import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/pages/address/NewAddressPage.dart';
import 'package:delivery/pages/address/AddressChange.dart';

class AddressManagePage extends StatefulWidget {
  @override
  _AddressManagePageState createState() => _AddressManagePageState();
}

class _AddressManagePageState extends State<AddressManagePage> {
  
  @override
  Widget build(BuildContext context) {
    double buttonWidth =
        MediaQuery.of(context).size.width * 0.9; // 화면 너비의 90%를 채우도록 설정

    return Scaffold(
      appBar: AppBar(
        title: Text('주소 관리'),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: () {
                // 새 주소 추가 기능 구현
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewAddressPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // 배경색을 흰색으로 설정
                foregroundColor: Colors.black, // 텍스트 색상을 검정색으로 설정
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 30, color: Colors.black),
                  SizedBox(width: 8), // 간격 조정
                  Expanded(
                    child: Text(
                      '새 주소 추가',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700, // 여기에 FontWeight.w700 추가
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30), // 간격 추가
          Container(
            height: 4, // Divider의 굵기 조절
            color: Colors.grey[300], // Divider의 색상 설정
          ),
          SizedBox(height: 10),
          Text(
            '현재 주소 목록',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 4, // Divider의 굵기 조절
            color: Colors.grey[300], // Divider의 색상 설정
          ),
          SizedBox(height: 30),
          Expanded(
            child: _buildAddressList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressList() {
    return Consumer<ItemListNotifier>(
      builder: (context, notifier, child) {
        String? homeAddress = notifier.homeAddress;
        String? workAddress = notifier.workAddress;
        List<String> addresses = notifier.addresses;

        return SingleChildScrollView(
          child: Column(
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
                title: Text(homeAddress ?? '집 주소가 없습니다.', style: TextStyle(fontWeight: FontWeight.w700)), // FontWeight.w700 추가
                onTap: () {
                  setState(() {});
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
                title: Text(workAddress ?? '회사 주소가 없습니다.', style: TextStyle(fontWeight: FontWeight.w700)), // FontWeight.w700 추가
                onTap: () {
                  setState(() {});
                },
              ),
              SizedBox(height: 10), // 주소 목록 아래 간격 조정
              Text(
                '    기타',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // 스크롤을 막기 위해 physics를 NeverScrollableScrollPhysics로 설정
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(addresses[index], style: TextStyle(fontWeight: FontWeight.w700)), // FontWeight.w700 추가
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        notifier.removeAddress(index);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
