import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _detailAddress = '';
  String _directions = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소 상세 정보'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: '상세주소 (아파트/동/호)',
              ),
              onChanged: (value) {
                setState(() {
                  _detailAddress = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: '길 안내 (예: 1층에 메가커피가 있는 건물, 공동현관 비밀번호 #1234)',
              ),
              onChanged: (value) {
                setState(() {
                  _directions = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // 사용자가 입력한 상세주소와 길 안내 정보를 활용하는 코드 작성
                print('상세주소: $_detailAddress');
                print('길 안내: $_directions');
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}