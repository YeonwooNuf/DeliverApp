import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/FavoritePage.dart';
import '../pages/MyPage.dart';
import '../pages/OrderHistoryPage.dart'; // 홈 페이지로 이동하는 예시

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
          //     child: Container(
          //       color: Colors.white,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.home, color: Colors.grey),
          //           Text('홈', style: TextStyle(color: Colors.grey)),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => FavoritePage()),
          //       );
          //     },
          //     child: Container(
          //       color: Colors.white,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.favorite, color: Colors.grey),
          //           Text('즐겨찾기', style: TextStyle(color: Colors.grey)),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => OrderHistoryPage()),
          //       );
          //     },
          //     child: Container(
          //       color: Colors.white,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.check_box_outlined, color: Colors.grey),
          //           Text('주문내역', style: TextStyle(color: Colors.grey)),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Expanded( 
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => MyPage()),
          //       );
          //     },
          //     child: Container(
          //       color: Colors.white,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.person, color: Colors.grey),
          //           Text('마이페이지', style: TextStyle(color: Colors.grey)),
          //         ],
          //       ),
          //     ),
            ),
          ),
        ],
      ),
    );
  }
}
