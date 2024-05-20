import 'package:delivery/category/CategorySelect.dart';
import 'package:delivery/pages/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:delivery/pages/AddressRegisterPage.dart';
import 'package:delivery/AddressChange.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 216, 214, 214),
      ),
      home: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: const HomeScreen(selectedIndex: 0),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final int selectedIndex;
  const HomeScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String? homeAddress = Provider.of<ItemListNotifier>(context).homeAddress;
    // String? workAddress = Provider.of<ItemListNotifier>(context).workAddress;
    // List<String> addresses = Provider.of<ItemListNotifier>(context).addresses;

    // int _selectedIndex = Provider.of<ItemListNotifier>(context).selectedIndex;

    // 선택된 인덱스에 저장된 주소 받아오기
    String selectedAddress = '';
    String _getSelectedAddressName(BuildContext context) {
      final itemListNotifier = Provider.of<ItemListNotifier>(context);

      // _selectedIndex 값에 따라 선택된 주소의 이름을 설정합니다.
      switch (itemListNotifier.selectedIndex) {
        case -2:
          selectedAddress = itemListNotifier.homeAddress ?? '집 주소가 없습니다.';
          break;
        case -1:
          selectedAddress = itemListNotifier.workAddress ?? '회사 주소가 없습니다.';
          break;
        default:
          selectedAddress =
              itemListNotifier.addresses[itemListNotifier.selectedIndex] ??
                  '기타 주소가 없습니다.';
          break;
      }

      String selectedAddressPrefix = selectedAddress.length >= 5
          ? selectedAddress.substring(0, 5)
          : selectedAddress;
      return selectedAddressPrefix;
    }

    // 주소의 앞에 5글자만 표현하기

    Widget _appBar() {
      String selectedAddress =
          Provider.of<ItemListNotifier>(context).selectedAddress;

      return SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(left: 16.0), // 좌측에 여백 추가
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: TextButton(
                  onPressed: () {
                    // Add your desired logic here
                    // For example, you can navigate to a new page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressRegisterPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Row의 크기를 내용물에 맞게 조정
                    children: [
                      Icon(Icons.location_on, color: Colors.black),
                      SizedBox(width: 8), // 아이콘과 텍스트 사이에 간격 추가
                      Text(
                        selectedAddress, // Add the selected address value here
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onTap: () {
                            // 검색 필드를 탭했을 때 SearchPage로 이동합니다.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()),
                            );
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: '검색',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

//카테고리 정의하는 메서드
    Widget _roundedContainer(String image, String title, VoidCallback onTap) {
      double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30), // 컨테이너의 모서리를 둥글게 설정
                ),
                width: squareSize,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    image,
                    width: squareSize,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _contents() {
      double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
      return Expanded(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _roundedContainer('assets/images/bibimbap.jpeg', '한식',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '한식')),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/sushi.jpeg', '일식',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '일식')),
                            );
                            // 클릭 시 수행할 동작 추가
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/jjajang.jpeg', '중식',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '중식')),
                            );
                            // 클릭 시 수행할 동작 추가
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/chicken.jpeg', '치킨',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '치킨')),
                            );
                            // 클릭 시 수행할 동작 추가
                          }),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _roundedContainer('assets/images/pizza.jpeg', '피자',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategorySelect(
                                      CategoryName: '피자')), // 클릭 시 수행할 동작 추가
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/pho.jpeg', '아시아',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '아시아')),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/burrito.jpeg', '멕시칸',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '멕시칸')),
                            );
                          }),
                          SizedBox(width: 8),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          _contents(),
        ],
      ),
    );
  }
}
