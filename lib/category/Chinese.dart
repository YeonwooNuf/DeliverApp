// import 'package:flutter/material.dart';

// class Chinese extends StatefulWidget {
//   @override
//   _JapaneseState createState() => _JapaneseState();
// }

// class _JapaneseState extends State<Chinese> {
//   int _currentIndex = 2; // 초기 탭을 일식으로 설정

//   final List<String> _titles = ["한식", "일식", "중식", "치킨", "피자", "아시아", "치킨"];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 7,
//       initialIndex: 2, // 초기 탭을 일식으로 설정
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             color: Colors.black,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: Center(
//             child: Text(
//               _titles[_currentIndex],
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.search, color: Colors.black),
//             ),
//           ],
//           bottom: TabBar(
//             labelColor: Colors.black,
//             isScrollable: true,
//             tabs: const [
//               Tab(text: "한식"),
//               Tab(text: "일식"),
//               Tab(text: "중식"),
//               Tab(text: "치킨"),
//               Tab(text: "피자"),
//               Tab(text: "아시아"),
//               Tab(text: "치킨"),
//             ],
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             Center(child: Text('한식 페이지')),
//             Center(child: Text('일식 페이지')),
//             Center(child: Text('중식 페이지')),
//             Center(child: Text('치킨 페이지')),
//             Center(child: Text('피자 페이지')),
//             Center(child: Text('아시아 페이지')),
//             Center(child: Text('치킨 페이지')),
//           ],
//         ),
//       ),
//     );
//   }
// }
