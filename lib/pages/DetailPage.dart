import 'package:flutter/material.dart';

void main() {
  runApp(DetailPage());
}

class DetailPage extends StatelessWidget {
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
            SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // 네모낳게 만드는 부분
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewPage()),
                      );
                    },
                    child: Text('리뷰'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // 네모낳게 만드는 부분
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                      );
                    },
                    child: Text('주문내역'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // 네모낳게 만드는 부분
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavoritesPage()),
                      );
                    },  
                    child: Text('즐겨찾기'),
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

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('리뷰 사진'),
            Text('리뷰 텍스트'),
          ],
        ),
      ),
    );
  }
}

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주문내역'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('주문했던 매장 사진'),
            Text('주문 정보'),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('즐겨찾기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('즐겨찾기 매장 사진'),
            Text('즐겨찾기 매장 정보'),
          ],
        ),
      ),
    );
  }
}