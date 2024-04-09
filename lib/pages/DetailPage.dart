import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String displayInfo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
                        borderRadius: BorderRadius.circular(0),
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
                        borderRadius: BorderRadius.circular(0),
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
                        borderRadius: BorderRadius.circular(0),
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
