import 'package:flutter/material.dart';
import 'package:delivery/pages/MenuSearchPage.dart';
import 'package:delivery/service/sv_favorite.dart';
import 'package:delivery/service/sv_store.dart';

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
      List<Map<String, dynamic>> _fetchedAllStores = await getAllStores();

      setState(() {
        allFavorites = _fetchedFavoriteData;
        allStores = _fetchedAllStores;

        favorites = buildFavoritesList(allFavorites);

        print('Fetched favorites: $allFavorites');
      });
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

// 즐겨찾기에 추가한 매장들만 필터링 해주는 함수
  List<Widget> buildFavoritesList(List<Map<String, dynamic>> favoritesData) {
    return favoritesData.map<Widget>((favorite) {
      Map<String, dynamic> store = allStores.firstWhere(
        (store) =>
            store['storeId'] ==
            favorite['favoriteStoreId'], // 아이디 값이 같은 매장의 정보들만 필터링
        orElse: () => {},
      );

      return buildItemWidget(
        favorite['favoriteStoreId'] as int,
        favorite['favoriteStoreName'],
        favorite['favorite_storeImg'],
        favorite['rating'].toString(),
        store['storeAddress'] ?? '주소를 찾을 수 없음',
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
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<String>(
                    value: selectedFilter,
                    underline: Container(),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
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
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [...favorites],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildItemWidget(
    int favoriteStoreId,
    String title,
    String imagePath,
    String starRating,
    String storeAddress,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuSearchPage(
              storeImage_URL: imagePath,
              storeName: title,
              storeId: favoriteStoreId,
              storeAddress: storeAddress,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
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
                      Text(
                        storeAddress,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                      Row(
                        children: [
                          ...List.generate(
                            int.parse(starRating),
                            (index) => Icon(Icons.star,
                                color: Colors.yellow, size: 20),
                          ),
                          SizedBox(width: 4),
                          Text(
                            starRating,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () {
                    deleteFavorite(int.parse(widget.userNumber), favoriteStoreId);
                    setState(() {
                      allFavorites.removeWhere((favorite) => favorite['favoriteStoreId'] == favoriteStoreId);
                      favorites = buildFavoritesList(allFavorites);
                      
                    });
                    
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
