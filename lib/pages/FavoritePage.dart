import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:delivery/pages/MenuSearchPage.dart';
import 'package:delivery/service/sv_favorite.dart';
import 'package:delivery/service/sv_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  late String mostFrequentCategory = '';

  @override
  void initState() {
    super.initState();
    selectedFilter = filterOptions[0];
    _fetchFavoriteData();
  }
  

  Future<void> _fetchFavoriteData() async {
    try {
      List<Map<String, dynamic>> _fetchedFavoriteData = await getUserFavorites(widget.userNumber);
      List<Map<String, dynamic>> _fetchedAllStores = await getAllStores();

      // 각 즐겨찾기에 평점 정보를 추가합니다.
      for (var favorite in _fetchedFavoriteData) {
        double averageRating = 0.0;
        try {
          averageRating = await getStoreRating(favorite['favoriteStoreId']);
        } catch (e) {
          print('Error fetching rating for store ${favorite['favoriteStoreId']}: $e');
        }
        favorite['averageRating'] = averageRating;
      }

      setState(() {
        allFavorites = _fetchedFavoriteData;
        allStores = _fetchedAllStores;

        favorites = buildFavoritesList(allFavorites);

        mostFrequentCategory = calculateMostFrequentCategory(allFavorites);

        print('Fetched favorites: $allFavorites');
      });

      // 즐겨찾기 수를 SharedPreferences에 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('favoritesCount', allFavorites.length);
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  Future<double> getStoreRating(int storeId) async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:8080/reviews/$storeId/rating'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData is Map<String, dynamic> && responseData.containsKey('averageRating')) {
        final averageRating = responseData['averageRating'];
        if (averageRating is double) {
          return averageRating;
        } else {
          throw Exception('Invalid average rating format: $averageRating');
        }
      } else {
        throw Exception('Invalid response format: $responseData');
      }
    } else {
      throw Exception('Failed to fetch store rating: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching store rating: $e');
    throw e;
  }
}

  // 즐겨찾기에 추가한 매장들만 필터링 해주는 함수
  List<Widget> buildFavoritesList(List<Map<String, dynamic>> favoritesData) {
    return favoritesData.map<Widget>((favorite) {
      Map<String, dynamic> store = allStores.firstWhere(
        (store) => store['storeId'] == favorite['favoriteStoreId'],
        orElse: () => {},
      );

      double averageRating = favorite['averageRating'] ?? 0.0;

      return buildItemWidget(
        favorite['favoriteStoreId'] as int,
        favorite['favoriteStoreName'],
        favorite['favorite_storeImg'],
        averageRating.toString(),
        store['storeAddress'] ?? '주소를 찾을 수 없음',
      );
    }).toList();
  }

  // 가장 많은 카테고리를 찾는 함수
  String calculateMostFrequentCategory(
      List<Map<String, dynamic>> favoritesData) {
    Map<String, int> categoryCount = {};
    for (var favorite in favoritesData) {
      String category = allStores.firstWhere(
            (store) => store['storeId'] == favorite['favoriteStoreId'],
            orElse: () => {},
          )['category'] ??
          '';

      if (category.isNotEmpty) {
        categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      }
    }

    String mostFrequent = '';
    int maxCount = 0;
    categoryCount.forEach((category, count) {
      if (count > maxCount) {
        maxCount = count;
        mostFrequent = category;
      }
    });

    return mostFrequent;
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
                  // 추천 위젯 추가
            buildRecommendationWidget(),
            SizedBox(width: 50,),
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


  // 추천 위젯 생성
  Widget buildRecommendationWidget() {
    return mostFrequentCategory.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              '추천: $mostFrequentCategory',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        : SizedBox.shrink();
  }
  
  Widget buildItemWidget(
  int favoriteStoreId,
  String title,
  String imagePath,
  String averageRating, // 변경: averageRating으로 수정
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
            userNumber: widget.userNumber,
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
                    Row(
                      children: [
                        ...List.generate(
                          double.parse(averageRating).round(), // 변경: double로 파싱한 후 반올림하여 사용
                          (index) => Icon(Icons.star,
                              color: Colors.yellow, size: 16), // 별 아이콘 크기 조정
                        ),
                        SizedBox(width: 4),
                        Text(
                          double.parse(averageRating).toStringAsFixed(1), // 한 자리까지만 표시
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
// <<<<<<< yeonwoo
//                 icon: Icon(Icons.delete),
//                 onPressed: () async {
//                   try {
//                     await deleteFavorite(int.parse(widget.userNumber), favoriteStoreId);
//                     _fetchFavoriteData(); // 데이터 갱신
//                   } catch (e) {
//                     print('Error deleting favorite: $e');
//                   }
// =======
                icon: Icon(Icons.delete, color: Colors.black),
                onPressed: () async {
                  await deleteFavorite(
                      int.parse(widget.userNumber), favoriteStoreId);
                  setState(() {
                    allFavorites.removeWhere((favorite) =>
                        favorite['favoriteStoreId'] == favoriteStoreId); // 클릭하면 바로 상태 업데이트
                    favorites = buildFavoritesList(allFavorites);
                  });

                  // 즐겨찾기 수를 SharedPreferences에 저장
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('favoritesCount', allFavorites.length);
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
