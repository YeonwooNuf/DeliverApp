import 'package:delivery/pages/MenuSearchPage.dart';
import 'package:delivery/service/sv_favorite.dart';
import 'package:delivery/service/sv_store.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  final String userNumber;
  const FavoritePage({Key? key, required this.userNumber}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<String> filterOptions = ['최근 추가한 순', '최근 주문한 순', '자주 주문한 순'];
  String? selectedFilter;
  late List<Widget> favorites = [];
  late List<Map<String, dynamic>> allFavorites = [];
  late List<Map<String, dynamic>> allStores = [];

  @override
  void initState() {
    super.initState();
    selectedFilter = filterOptions[0];
    _fetchFavoriteData();
  }

  Future<void> _fetchFavoriteData() async {
    try {
      List<Map<String, dynamic>> _fetchedFavoriteData =
          await getUserFavorites(widget.userNumber);
      //모든 메장 데이터

      setState(() {
        allFavorites = _fetchedFavoriteData;

        favorites = buildFavoritesList(allFavorites);

        print('Fetched favorites: $allFavorites'); // 콘솔에 데이터 출력
      });
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  List<Widget> buildFavoritesList(List<Map<String, dynamic>> favoritesData) {
    return favoritesData.map<Widget>((favorite) {
      return buildItemWidget(
        favorite['favorite_storeImg'],
        favorite['favoriteStoreName'],
        favorite['rating'].toString(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '즐겨찾기',
          style: TextStyle(
              color: Colors.black,
              fontFamily: "MangoDdobak",
              fontWeight: FontWeight.w700), // 텍스트 색상 변경
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // 배경색 변경
        elevation: 0, // 그림자 없애기
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05), // 양쪽에 상대적인 패딩 추가
        child: Column(
          children: [
            // 필터 드롭다운을 오른쪽으로 정렬
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
                children: [
                  DropdownButton<String>(
                    value: selectedFilter,
                    underline: Container(),
                    dropdownColor: Colors.white, // 드롭다운 메뉴 배경색 흰색으로 변경
                    icon: Icon(Icons.arrow_drop_down,
                        color: Colors.black), // 드롭다운 버튼의 아이콘 설정
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue;
                      });
                    },
                    items: filterOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Text(
                              value,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: "MangoDdobak",
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                                width: screenWidth * 0.01), // 아이콘과 텍스트 사이 간격
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // 즐겨찾기 목록
            Expanded(
              child: ListView(
                children: [
                  ...favorites,
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Scaffold의 배경색을 흰색으로 변경
    );
  }

  Widget buildItemWidget(String imagePath, String title, String starRating,) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => MenuSearchPage(
          //               storeImage_URL: storeImage_URL,
          //               storeName: storeName,
          //               storeId: storeId,
          //               storeAddress: storeAddress,
          //             )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200], // 배경색을 회색 계통으로 변경
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    children: [
                      Image.network(
                        imagePath,
                        width: 110,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: List.generate(
                                int.parse(starRating),
                                (index) => Icon(Icons.star,
                                    color: Colors.yellow, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}