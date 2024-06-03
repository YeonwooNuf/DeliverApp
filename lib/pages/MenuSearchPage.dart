import 'package:delivery/service/sv_menu.dart';
import 'package:flutter/material.dart';

class MenuSearchPage extends StatefulWidget {
  final String image_URL;
  final String storeName;
  final int storeId;

  MenuSearchPage({required this.image_URL, required this.storeName, required this.storeId});

  @override
  _MenuSearchPageState createState() => _MenuSearchPageState();
}

class _MenuSearchPageState extends State<MenuSearchPage> {
  late List<Map<String, dynamic>> _productId = [];
  late List<Map<String, dynamic>> _menuStoreId = [];
  late List<Map<String, dynamic>> _productName = [];
  late List<Map<String, dynamic>> _price = [];
  late List<Map<String, dynamic>> _productImg = [];
  late List<Map<String, dynamic>> _allMenus = [];

  @override
  void initState() {
    super.initState();
    _fetchMenuData();
  }

  // 메뉴 정보를 불러오는 비동기 함수
  Future<void> _fetchMenuData() async {
  
      _productId = await getProductId();
      _menuStoreId = await getMenu_StoreId();
      _productName = await getProductName();
      _price = await getPrice();
      _productImg = await getProductImg();
      _allMenus = await getAllMenus();

      print('메뉴 정보들:');
      _allMenus.forEach((menu) {
        print(menu);
      });
  }
   
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // SingleChildScrollView로 감싸기
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      //이미지 부분
                      height: MediaQuery.of(context).size.height * 0.32, // 화면의 절반 높이
                      child: Image.network(
                        widget.image_URL,
                        fit: BoxFit.fill, // 이미지를 컨테이너에 맞춤
                        width: double.infinity, // 이미지가 컨테이너에 가득 차도록 가로 너비를 확장
                        height: double.infinity, // 이미지가 컨테이너에 가득 차도록 세로 너비를 확장
                      ),
                    ),
                    // AppBar 정의
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        backgroundColor: Colors.transparent, // 투명한 AppBar
                        elevation: 0, // 그림자 제거
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3, // 화면의 절반 높이
                  color: Colors.blue,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _ReviewBox(context),
                        SizedBox(width: 20), // 간격 추가
                        _ReviewBox(context),
                        SizedBox(width: 20), // 간격 추가
                        _ReviewBox(context),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3, // 화면의 절반 높이
                  color: Colors.orange,
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: MediaQuery.of(context).size.width * 0.04, // 왼쪽 여백을 화면의 너비를 기준으로 설정합니다.
              right: MediaQuery.of(context).size.width * 0.04, // 오른쪽 여백을 화면의 너비를 기준으로 설정합니다.
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15, // 화면의 절반 높이
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 그림자의 색상 및 투명도
                      spreadRadius: 5, // 그림자의 확산 정도
                      blurRadius: 7, // 그림자의 흐림 정도
                      offset: Offset(0, 3), // 그림자의 위치 (수평, 수직)
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey, // 테두리 색상
                    width: 2, // 테두리 너비
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.storeName, // 표시할 텍스트
                    style: TextStyle(
                      fontSize: 30, // 텍스트 크기
                      color: Colors.black, // 텍스트 색상
                      fontFamily: "MangoDdobak",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ReviewBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // 회색 테두리 추가
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 175), // 왼쪽 여백 추가
        child: Container(
          width: MediaQuery.of(context).size.height * 0.01,
          height: MediaQuery.of(context).size.height * 0.01,
          color: Colors.black,
        ),
      ),
    );
  }
}
