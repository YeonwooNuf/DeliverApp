import 'package:flutter/material.dart';
import 'package:delivery/pages/DetailPage.dart';
import 'package:delivery/pages/AddressManagePage.dart';
import 'package:delivery/pages/FavoritePage.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '배달 앱',
      home: DeliveryScreen(),
    );
  }
}

class DeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage()),
                  );
                },
                child: Text(
                  '자세히 보기',
                  style: TextStyle(fontSize: 18),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 247, 245, 245)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddressManagePage()),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 34),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            '주소관리',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavoritePage()),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border, size: 34),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            '즐겨찾기',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogoutPage()),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app, size: 34),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            '로그아웃',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그아웃'),
      ),
      body: Center(
        child: Text('로그아웃 페이지'),
      ),
    );
  }
}
