import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/pages/AddressRegisterPage.dart';
import 'package:delivery/AddressChange.dart';
import 'package:delivery/pages/HomeAddressPage.dart';
import 'package:delivery/pages/CompanyAddressPage.dart';

class AddressManagePage extends StatefulWidget {
  @override
  _AddressManagePageState createState() => _AddressManagePageState();
}

class _AddressManagePageState extends State<AddressManagePage> {
  // List<String> addresses = [
  //   '인하대,인하공전,정석항공고 인천광역시 미추홀구 인하로 100 수준원점',
  //   '인천광역시 미추홀구 인하로105번길 43 302호',
  // ];

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.9; // 화면 너비의 90%를 채우도록 설정

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
                  MaterialPageRoute(builder: (context) => AddressRegisterPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 255, 255), // 배경색을 흰색으로 설정
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
                      style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25), // 간격 추가
          SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeAddressPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // 배경색을 흰색으로 설정
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
                  Icon(Icons.home, size: 30, color: Colors.black),
                  SizedBox(width: 8), // 간격 조정
                  Expanded(
                    child: Text(
                      '집 주소 추가',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5), // 간격 추가
          SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: () {
                // 회사 주소 추가 기능 구현
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompanyAddressPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // 배경색을 흰색으로 설정
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
                  Icon(Icons.work, size: 30, color: Colors.black),
                  SizedBox(width: 8), // 간격 조정
                  Expanded(
                    child: Text(
                      '회사 주소 추가',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
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
          SizedBox(height:30),
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
      return ListView.builder(
        itemCount: notifier.addresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.location_on),
            title: Text(notifier.addresses[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                notifier.removeAddress(index);
              },
            ),
          );
        },
      );
    },
  );
}
}