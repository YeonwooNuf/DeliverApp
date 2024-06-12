import 'dart:convert';

import 'package:delivery/dto/favorite_dto.dart';
import 'package:delivery/pages/MenuSearchPage.dart';
import 'package:delivery/service/sv_favorite.dart';
import 'package:delivery/service/sv_store.dart';
import 'package:delivery/service/sv_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class CategorySelect extends StatefulWidget {
  final String CategoryName;
  final String userNumber;
  CategorySelect({required this.CategoryName, required this.userNumber});
  @override
  _JapaneseState createState() => _JapaneseState();
}
class _JapaneseState extends State<CategorySelect> {
  var currentValue = '1'; // 드롭다운메뉴 변수
  final List<String> _items = <String>['가나다순', '신규매장순']; // 드롭다운메뉴
  late String selectedValue = _items[0];
  final List<String> _titles = [
    "한식",
    "일식",
    "중국집",
    "치킨",
    "피자",
    "햄버거",
    "분식",
    "족발"
  ];
  late int _currentIndex; // 초기탭 배열번호 선언
  bool IsFilled = false;
  // 매장정보 따로 받아옴.
  late List<Map<String, dynamic>> _storeName = [];
  late List<Map<String, dynamic>> _storeImg = [];
  late List<Map<String, dynamic>> _allStores = []; // 매장 정보 전체 받아옴
  @override
  void initState() {
    super.initState();
    _currentIndex = _titles.indexOf(widget.CategoryName); // initState 메서드 내에서 호출
    _fetchStoreData(); // 데이터 불러오기
  }
  // 스토어 데이터를 불러오는 비동기 함수
  Future<void> _fetchStoreData() async {
    _storeName = await getStoreName();
    _storeImg = await getStoreImg();
    _allStores = await getAllStores();
    
    for (var store in _allStores) {
    print(store);
    double averageRating = await getStoreRating(store['storeId']);
    store['averageRating'] = averageRating; // 가져온 평균 별점을 가게 정보에 추가
    print('매장정보들:');
  }
  
  setState(() {}); // 상태 업데이트
  }
  //별점평균 불러오는 비동기 함수
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
  // 정렬 함수 추가
  void _sortStores() {
    setState(() {
      if (selectedValue == '가나다순') {
        _allStores.sort((Map<String, dynamic> a, Map<String, dynamic> b) => a['storeName'].compareTo(b['storeName']));
      } else if (selectedValue == '신규매장순') {
        _allStores.sort((Map<String, dynamic> a, Map<String, dynamic> b) => b['storeId'].compareTo(a['storeId']));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      initialIndex: _currentIndex, // 초기 탭
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(
              _titles[_currentIndex], // 탭을 누를때마다 타이틀 변경되게 함.
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'MangoDdobak',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.black),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60), // 탭바 높이 + 추가 컨테이너 높이
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: "한식"),
                    Tab(text: "일식"),
                    Tab(text: "중국집"),
                    Tab(text: "치킨"),
                    Tab(text: "피자"),
                    Tab(text: "햄버거"),
                    Tab(text: "분식"),
                    Tab(text: "족발"),
                  ],
                  indicatorColor: Colors.grey, // 여기서 선의 색상을 설정합니다
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Row를 오른쪽 정렬합니다
                    children: [_Filter()],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(_titles.length, (index) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildImagesForCategory(index, widget.userNumber),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
  //맨위에 있는 필터 메서드
  Widget _Filter() {
    return Container(
      height: 30,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // 테두리 색상
          width: 1.0, // 테두리 두께
        ),
        borderRadius: BorderRadius.circular(30), // 테두리 모양 (원형)
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        iconSize: 24,
        style: const TextStyle(
          color: Colors.black,
        ),
        underline: Container(), // 밑줄 감추기
        dropdownColor: Colors.white,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
            _sortStores(); // 정렬 함수 호출
          });
        },
        items: _items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
  // 이미지 클릭 메서드
  Widget _Image(String storeImage_URL, String storeName, int storeId,
    String storeAddress, String userNumber, double averageRating) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuSearchPage(
              storeImage_URL: storeImage_URL,
              storeName: storeName,
              storeId: storeId,
              storeAddress: storeAddress,
              userNumber: widget.userNumber,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    storeImage_URL,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: HeartIconButton(
                  userNumber: userNumber,
                  storeId: '$storeId',
                  storeImg: storeImage_URL,
                  storeName: storeName,
                ),
              ),
            ],
          ),
          SizedBox(height: 8), // 이미지와 매장명 간의 간격 조절
          Text(
            storeName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 4), // 매장명과 별점 간의 간격 조절
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              SizedBox(width: 4), // 별점 아이콘과 평점 간의 간격 조절
              Text(
                averageRating.toStringAsFixed(1), // 평균 별점 표시 (소수점 첫 번째 자리까지)
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
// 이미지 위젯들을 반환하는 메서드
  Widget _buildImagesForCategory(int categoryIndex, String userNumber) {
    if (_storeName.isEmpty || _storeImg.isEmpty) {
      return CircularProgressIndicator(); // 데이터가 로드되기 전에 로딩 인디케이터 표시
    } else {
      // 선택된 카테고리에 해당하는 데이터 필터링
      List<Map<String, dynamic>> filteredStoreData = [];
      switch (categoryIndex) {
        case 0: // 한식
          filteredStoreData =
              _allStores.where((store) => store['category'] == '한식').toList();
          break;
        case 1: // 일식
          filteredStoreData =
              _allStores.where((store) => store['category'] == '일식').toList();
          break;
        case 2: // 중식
          filteredStoreData =
              _allStores.where((store) => store['category'] == '중국집').toList();
          break;
        case 3: // 치킨
          filteredStoreData =
              _allStores.where((store) => store['category'] == '치킨').toList();
          break;
        case 4: // 피자
          filteredStoreData =
              _allStores.where((store) => store['category'] == '피자').toList();
          break;
        case 5: // 아시아
          filteredStoreData =
              _allStores.where((store) => store['category'] == '햄버거').toList();
          break;
        case 6: // 멕시칸
          filteredStoreData =
              _allStores.where((store) => store['category'] == '분식').toList();
          break;
        case 7: // 멕시칸
          filteredStoreData =
              _allStores.where((store) => store['category'] == '족발').toList();
          break;
        default:
          break;
      }
      if (filteredStoreData.isEmpty) {
        return SizedBox.shrink();
      }
      // 필터링된 데이터에 대해 이미지 위젯 생성
      return Column(
        children: List.generate(filteredStoreData.length, (index) {
          final storeData = filteredStoreData[index];
          final storeId = storeData['storeId'] ?? '';
          final storeAddress = storeData['storeAddress'] ?? '';
          final storeImg = _allStores.firstWhere(
                (element) => element['storeId'] == storeId,
                orElse: () => {'storeImg': ''},
              )['storeImg'] ??
              ''; // 이미지가 없을 때 처리
          final storeName = _allStores.firstWhere(
                (element) => element['storeId'] == storeId,
                orElse: () => {'storeName': '매장정보 없음'}, // 매장명이 없을 때 처리
              )['storeName'] ??
              '매장정보 없음';
          final averageRating = _allStores.firstWhere(
                (element) => element['storeId'] == storeId,
                orElse: () => {'averageRating': 0.0}, // 별점이 없을 때 처리
              )['averageRating'] ?? 0.0;
          return _Image(
              storeImg, // 이미지 URL
              storeName, // 스토어 이름
              storeId,
              storeAddress,
              userNumber,
              averageRating,);
        }),
      );
    }
  }
}
// 하트 아이콘
class HeartIconButton extends StatefulWidget {
  final String userNumber;
  final String storeId;
  final String storeImg;
  final String storeName;
  final double? rating;
  HeartIconButton({
    required this.userNumber,
    required this.storeId,
    required this.storeImg,
    required this.storeName,
    this.rating,
  });
  @override
  _HeartIconButtonState createState() => _HeartIconButtonState();
}
class _HeartIconButtonState extends State<HeartIconButton> {
  bool isFilled = false;
  @override
  void initState() {
    super.initState();
    // 사용자의 즐겨찾기 목록을 로드하여 해당 상점이 있는지 확인합니다.
    checkIfStoreIsFavorite();
  }
  // 사용자의 즐겨찾기 목록을 로드하여 해당 상점이 있는지 확인하는 함수
  Future<void> checkIfStoreIsFavorite() async {
    List<Map<String, dynamic>> favorites = await getUserFavorites(widget.userNumber);
    setState(() {
      // 사용자의 즐겨찾기 목록에 특정 상점이 포함되어 있는지 확인
      isFilled = favorites.any((favorite) => favorite['favoriteStoreId'].toString() == widget.storeId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isFilled
          ? Icon(Icons.favorite, color: Colors.red)
          : Icon(Icons.favorite_border, color: Colors.white),
      onPressed: () async {
        // 상태를 먼저 변경합
        setState(() {
          isFilled = !isFilled;
        });
        // 상태 변경 후, 즐겨찾기 추가 또는 삭제 로직을 처리
        if (isFilled) {
          // 즐겨찾기를 추가하는 로직
          final favorite = FavoriteDto(
            favorite_userNumber: int.parse(widget.userNumber),
            favorite_storeId: widget.storeId,
            favorite_storeImg: widget.storeImg,
            favorite_storeName: widget.storeName,
            rating: widget.rating.toString(), // 리뷰 페이지 만들면 변수 갖다 박아주세요 ^^
          );
          print('서버로 전송하는 favorite데이터: $favorite');
          try {
            await saveFavorite(favorite); // 하트 채우면 즐겨찾기 저장
          } catch (e) {
            print('favorite 전송 실패: $e');
          }
        } else {
          // 즐겨찾기를 삭제
          try {
            await deleteFavorite(int.parse(widget.userNumber), int.parse(widget.storeId)); // 하트 비우면 즐겨찾기 삭제
          } catch (e) {
            print('삭제 실패: $e');
          }
        }
      },
    );
  }
}