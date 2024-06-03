import 'package:delivery/service/sv_menu.dart';
import 'package:flutter/material.dart';

class MenuSearchPage extends StatefulWidget {
  final String image_URL;
  final String storeName;
  final int storeId;
  final String storeAddress;

  MenuSearchPage(
      {required this.image_URL,
      required this.storeName,
      required this.storeId, required this.storeAddress});

  @override
  _MenuSearchPageState createState() => _MenuSearchPageState();
}

class _MenuSearchPageState extends State<MenuSearchPage> {
  late List<Map<String, dynamic>> _filteredMenus = [];

  @override
  void initState() {
    super.initState();
    _fetchMenuData();
  }

  // 메뉴 정보를 불러오는 비동기 함수
  Future<void> _fetchMenuData() async {
    List<Map<String, dynamic>> allMenus = await getAllMenus();

    setState(() {
      _filteredMenus = allMenus
          .where((menu) => menu['menu_storeId'] == widget.storeId)
          .toList();

      print('필터링된 메뉴 정보들:');
      _filteredMenus.forEach((menu) {
        print(menu);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      extendBodyBehindAppBar: true, // AppBar를 body 뒤에 확장하여 배경 이미지를 덮도록 함
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      // 이미지 부분
                      height: MediaQuery.of(context).size.height *
                          0.32, // 화면의 높이 32%
                      child: Image.network(
                        widget.image_URL,
                        fit: BoxFit.fill, // 이미지를 컨테이너에 맞춤
                        width: double.infinity, // 이미지가 컨테이너에 가득 차도록 가로 너비를 확장
                        height: double.infinity, // 이미지가 컨테이너에 가득 차도록 세로 너비를 확장
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height *
                          0.2, // 화면의 높이 20%에 위치
                      left: MediaQuery.of(context).size.width *
                          0.04, // 왼쪽 여백을 화면의 너비를 기준으로 설정
                      right: MediaQuery.of(context).size.width *
                          0.04, // 오른쪽 여백을 화면의 너비를 기준으로 설정
                      child: Container(
                        height: MediaQuery.of(context).size.height *
                            0.1, // 화면의 높이 10%
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // 그림자의 색상 및 투명도
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
                Container(
                  height:
                      MediaQuery.of(context).size.height * 0.1, // 화면의 높이 30%
                  color: Colors.blue,
                  child: Text('${widget.storeAddress}'),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          _filteredMenus.map((menu) => _MenuBox(menu)).toList(),//여기에 리뷰 리스트 뜨게 해야함 리뷰함수 만들어서 구현 ㄱㄱ
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.yellow,
                  child: Center(
                    child: Text(
                      "메뉴",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height:
                      MediaQuery.of(context).size.height * 0.3, // 화면의 높이 30%
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: _filteredMenus.length,
                    itemBuilder: (context, index) {
                      return _MenuBox(_filteredMenus[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _MenuBox(Map<String, dynamic> menu) {
    return Container(
      margin: EdgeInsets.all(10), // 각 메뉴 간의 간격을 위해 여백 추가
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // 회색 테두리 추가
        borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 설정
      ),
      child: Padding(
        padding: EdgeInsets.all(10), // 여백 추가
        child: Row(
          children: [
            Image.network(
              menu['productImg'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  menu['productName'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${menu['price']} 원',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
