import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delivery/pages/DetailPage.dart';
import 'package:delivery/pages/address/AddressManagePage.dart';
import 'package:delivery/pages/FavoritePage.dart';
import 'package:delivery/pages/login/LogoutPage.dart';

class MyPage extends StatefulWidget {
  final String name;
  final String phone;
  final String userNumber;

  MyPage({required this.name, required this.phone, required this.userNumber});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int favoritesCount = 0;
  int reviewsCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchFavoritesCount();
  }

  Future<void> _fetchFavoritesCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritesCount = prefs.getInt('favoritesCount') ?? 0;
    });
  }
  Future<void> _fetchReviewsCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      reviewsCount = prefs.getInt('reviewsCount') ?? 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'MangoDdobak'),
          headline2: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'MangoDdobak'),
          bodyText1: TextStyle(fontSize: 16, fontFamily: 'MangoDdobak'),
          button: TextStyle(fontSize: 20, fontFamily: 'MangoDdobak'),
        ),
      ),
      home: DeliveryScreen(
        name: widget.name,
        phone: widget.phone,
        userNumber: widget.userNumber,
        updateFavoritesCount: _updateFavoritesCount,
        updateReviewsCount: _updateReviewsCount,
      ),
    );
  }

  // 즐겨찾기 개수를 업데이트하는 콜백 함수
  void _updateFavoritesCount(int count) {
    setState(() {
      favoritesCount = count;
    });
  }
  void _updateReviewsCount(int count) {
    setState(() {
      reviewsCount = count;
    });
  }
}

class DeliveryScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String userNumber;
  final Function(int) updateFavoritesCount;
  final Function(int) updateReviewsCount;

  DeliveryScreen({
    required this.name,
    required this.phone,
    required this.userNumber,
    required this.updateFavoritesCount,
    required this.updateReviewsCount,
  });

  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  int favoritesCount = 0;
  int reviewsCount = 0;

  String formatPhoneNumber(String phoneNumber) {
    // 전화번호 형식 변환(사이사이 - 추가되게)
    if (phoneNumber.length == 11) {
      return phoneNumber.substring(0, 3) +
          '-' +
          phoneNumber.substring(3, 7) +
          '-' +
          phoneNumber.substring(7);
    } else {
      return phoneNumber;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFavoritesCount();
    _fetchReviewsCount();
  }



  Future<void> _fetchFavoritesCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritesCount = prefs.getInt('favoritesCount') ?? 0;
    });
  }

  Future<void> _fetchReviewsCount() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    reviewsCount = prefs.getInt('reviewsCount') ?? 0;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.headline1, // headline1 스타일 사용
            ),
            SizedBox(height: 30),
            Text(
              formatPhoneNumber(widget.phone),
              style: Theme.of(context).textTheme.headline2, // headline2 스타일 사용
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(
                    '$reviewsCount',
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
                    '$favoritesCount',
                    style: TextStyle(fontSize: 18),
                  ),
                  backgroundColor: Colors.grey[300],
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              '나의 리뷰       |         주문내역         |       즐겨찾기',
              style: Theme.of(context).textTheme.bodyText1, // bodyText1 스타일 사용
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(name: widget.name, phone: widget.phone)),
                  );
                },
                child: Text(
                  '자세히 보기',
                  style: Theme.of(context).textTheme.button, // button 스타일 사용
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 247, 245, 245)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  elevation: MaterialStateProperty.all<double>(8), // 그림자 추가
                  shadowColor:
                      MaterialStateProperty.all<Color>(Colors.grey), // 그림자 색상
                ),
              ),
            ),
            SizedBox(height: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuButton(
                  icon: Icons.location_on,
                  text: '주소관리',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressManagePage(userNumber: widget.userNumber,)),
                    );
                  },
                ),
                SizedBox(height: 16),
                _buildMenuButton(
                  icon: Icons.favorite_border,
                  text: '즐겨찾기',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavoritePage(
                                userNumber: widget.userNumber,
                              )),
                    );
                  },
                ),
                SizedBox(height: 16),
                _buildMenuButton(
                  icon: Icons.logout,
                  text: '로그아웃',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogoutPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      {required IconData icon,
      required String text,
      required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 60, // 버튼 높이 조정
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center, // 텍스트를 중앙에 정렬
                style: Theme.of(context).textTheme.button, // button 스타일 사용
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          elevation: MaterialStateProperty.all<double>(8), // 그림자 추가
          shadowColor: MaterialStateProperty.all<Color>(Colors.grey), // 그림자 색상
        ),
      ),
    );
  }
}
