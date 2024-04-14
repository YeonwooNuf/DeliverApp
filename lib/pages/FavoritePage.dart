import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: FavoritePage())); // MaterialApp 추가

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _DropDownButtonPageState();
}

class _DropDownButtonPageState extends State<FavoritePage> {
  var currentValue = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>( // PopupMenuButton으로 변경
            onSelected: (String value) { // 메뉴 항목 선택 시 동작
              setState(() {
                currentValue = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: '1',
                child: Text('최근 추가한 순'),
              ),
              const PopupMenuItem<String>(
                value: '2',
                child: Text('가나다 순'),
              ),
            ],
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         color: Colors.red,
      //         height: 180,
      //         child: Row(
      //           children: [
      //             // Padding(
      //             //   padding: EdgeInsets.all(10.0),
      //             // )
      //           ],
      //         ),
      //       ),
      //       Container(
      //         color: Colors.blue,
      //         height: 180,
      //       ),
      //       Container(
      //         color: Colors.yellow,
      //         height: 180,
      //       ),
      //       Container(
      //         color: Colors.green,
      //         height: 180,
      //       ),
      //       Container(
      //         color: Colors.purple,
      //         height: 180,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
