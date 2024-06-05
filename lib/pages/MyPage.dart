import 'package:flutter/material.dart';
import 'package:delivery/pages/DetailPage.dart';
import 'package:delivery/pages/address/AddressManagePage.dart';
import 'package:delivery/pages/FavoritePage.dart';
import 'package:delivery/pages/login/LogoutPage.dart';
import 'package:delivery/pages/login/LoginPage.dart';

class MyPage extends StatelessWidget {
  //Mypage로 loginpage에서 이름과 전화번호를 전달해줌.
   final String  name ;
   final String  phone;

   MyPage({required this.name, required this.phone}); // 생성자 추가


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DeliveryScreen(name: name, phone: phone),
    );
  }
}



class DeliveryScreen extends StatelessWidget {

   String name ;
   String  phone;

   DeliveryScreen({required this.name, required this.phone});

   String formatPhoneNumber(String phoneNumber) {
     // 전화번호 형식 변환(사이사이 - 추가되게)
     return phoneNumber.substring(0, 3) + '-' + phoneNumber.substring(3, 7) + '-' + phoneNumber.substring(7);
   }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Text(
              '$name',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              '${formatPhoneNumber(phone)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60),
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
                    MaterialPageRoute(builder: (context) => DetailPage(name: name, phone: phone)),
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
                        MaterialPageRoute(builder: (context) => FavoritePage(userNumber: '',)),
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


// class LogoutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('로그아웃'),
//       ),
//       body: Center(
//         child: Text('로그아웃 페이지'),
//       ),
//     );
//   }
// }