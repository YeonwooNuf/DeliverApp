import 'package:flutter/material.dart';

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
          _menuBtn(),
          Icon(Icons.arrow_drop_down,color: Colors.black,),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 180,
            )
          ],
        ),
      )
          
    );
  }

  Widget _menuBtn() {
    return DropdownButton(
      value: currentValue,
      items: [
        DropdownMenuItem(value: '1', child: Text('최근 추가한 순')),
        DropdownMenuItem(value: '2', child: Text('가나다 순')),
      ],
      style: TextStyle(color: Colors.black),
      dropdownColor: Colors.white,
      onChanged: (String? value) {
        setState(() {
          currentValue = value!;
        });
      },
    );
  }
}