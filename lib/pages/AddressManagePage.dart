import 'package:flutter/material.dart';
import 'AddressRegisterPage.dart';

class AddressManagePage extends StatefulWidget {
  @override
  _AddressManagePageState createState() => _AddressManagePageState();
}

class _AddressManagePageState extends State<AddressManagePage> {
  List<String> addresses = [
    '인하대,인하공전,정석항공고 인천광역시 미추홀구 인하로 100 수준원점',
    '인천광역시 미추홀구 인하로105번길 43 302호',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소 관리'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 새 주소 추가 기능 구현
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressRegisterPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, size: 30, color: Colors.black),
                SizedBox(width: 16),
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
          SizedBox(height: 25), // 간격 추가
          ElevatedButton(
            onPressed: () {
              // 집 주소 추가 기능 구현
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, size: 30, color: Colors.black),
                SizedBox(width: 16),
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
          SizedBox(height: 5), // 간격 추가
          ElevatedButton(
            onPressed: () {
              // 회사 주소 추가 기능 구현
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work, size: 30, color: Colors.black),
                SizedBox(width: 30),
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
          SizedBox(height: 30), // 간격 추가
          Divider(height: 1, color: Colors.grey), // 구분선 추가
          SizedBox(height: 10),
          Text(
            '현재 주소 목록',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Divider(height: 1, color: Colors.grey), // 구분선 추가
          SizedBox(height:30),
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(addresses[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // 주소 삭제 기능 구현
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
