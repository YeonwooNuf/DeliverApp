import 'package:flutter/material.dart';

/* void main() {
  runApp(DeliveryScreen());
} */

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '배달 앱',
      home: DeliveryScreen(),
    );
  }
}

class DeliveryScreen extends StatefulWidget {
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
} // 버튼 누를 때 페이지 이동말고 같은 페이지에서 데이터 띄우는 코드

class _DeliveryScreenState extends State<DeliveryScreen> {
  String displayInfo = '';  // 버튼 누르면 뜨는 데이터 변수값

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('어플 이름'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Text(
              '장연우',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              '010-2995-3117',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(
                    '1',
                    style: TextStyle(fontSize: 18),
                  ),
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(width: 90),
                CircleAvatar(
                  radius: 20,
                  child: Text(
                    '1',
                    style: TextStyle(fontSize: 18),
                  ),
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(width: 90),
                CircleAvatar(
                  radius: 20,
                  child: Text(
                    '0',
                    style: TextStyle(fontSize: 18),
                  ),
                  backgroundColor: Colors.grey[300],
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              '나의 리뷰       |         주문내역         |       즐겨찾기',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // 네모낳게 만드는 부분
                      ),
                    ),
                    onPressed: () {
                      updateDisplayInfo('리뷰 정보 표시');
                    },
                    child: Text('리뷰'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // 네모낳게 만드는 부분
                      ),
                    ),
                    onPressed: () {
                      updateDisplayInfo('주문내역 정보 표시');
                    },
                    child: Text('주문내역'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // 네모낳게 만드는 부분
                      ),
                    ),
                    onPressed: () {
                      updateDisplayInfo('즐겨찾기 정보 표시');
                    },  
                    child: Text('즐겨찾기'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              displayInfo,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void updateDisplayInfo(String info) {
    setState(() {
      displayInfo = info;
    });
  }
}
