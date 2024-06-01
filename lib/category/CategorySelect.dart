import 'package:delivery/pages/MenuSearchPage.dart';
import 'package:delivery/service/sv_menu.dart';
import 'package:delivery/service/sv_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategorySelect extends StatefulWidget {
  final String CategoryName;
  CategorySelect({required this.CategoryName});

  @override
  _JapaneseState createState() => _JapaneseState();
}

class _JapaneseState extends State<CategorySelect> {
  var currentValue = '1'; //드롭다운메뉴 변수
  final List<String> _items = <String>['가나다순', '신규매장순']; //드롭다운메뉴
  late String selectedValue = _items[0];
  final List<String> _titles = ["한식", "일식", "중식", "치킨", "피자", "아시아", "멕시칸"];
  late int _currentIndex; //초기탭 배열번호 선언
  bool IsFilled = false;

  late List<Map<String, dynamic>> _storeId = []; 
  late List<Map<String, dynamic>> _storeName = []; 
  late List<Map<String, dynamic>> _storeAddress = []; 
  late List<Map<String, dynamic>> _storeCategory = []; 
  late List<Map<String, dynamic>> _storeImg = []; 
  late List<Map<String, dynamic>> _allStores= []; // 매장 정보 전체 받아옴

  @override
  void initState() {
    super.initState();
    _currentIndex =
        _titles.indexOf(widget.CategoryName); // initState 메서드 내에서 호출
    _fetchStoreData(); // 데이터 불러오기
  }

  // 스토어 데이터를 불러오는 비동기 함수
  Future<void> _fetchStoreData() async {
    _storeId = await getStoreId();
    _storeName = await getStoreName();
    _storeAddress = await getStoreAddress();
    _storeCategory = await getCategory();
    _storeImg = await getStoreImg();
    _allStores = await getAllStores();
    
    print('매장정보들:');
    _allStores.forEach((store) {
      print(store);
    }); 

    setState(() {}); // 상태 업데이트

    // 각 카테고리를 콘솔에 출력
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
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
              _titles[_currentIndex], //탭을 누를때마다 타이틀 변경되게 함.
              style: TextStyle(color: Colors.black),
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
                    Tab(text: "중식"),
                    Tab(text: "치킨"),
                    Tab(text: "피자"),
                    Tab(text: "아시아"),
                    Tab(text: "멕시칸"),
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
                  _buildImagesForCategory(index),
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
        style: const TextStyle(color: Colors.black),
        underline: Container(), // 밑줄 감추기
        dropdownColor: Colors.white,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
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
  Widget _Image(String image_URL, String storeName) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuSearchPage(
                        image_URL: image_URL,
                        storeName: storeName,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      '${image_URL}',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: HeartIconButton(),
              ),
            ],
          ),
          SizedBox(height: 8), // 이미지와 매장명 간의 간격 조절
          Text(
            storeName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

// 이미지 위젯들을 반환하는 메서드
  Widget _buildImagesForCategory(int categoryIndex) {
    if (_storeName.isEmpty || _storeImg.isEmpty) {
      return CircularProgressIndicator(); // 데이터가 로드되기 전에 로딩 인디케이터 표시
    } else {
      // 선택된 카테고리에 해당하는 데이터 필터링
      List<Map<String, dynamic>> filteredStoreData = [];
      switch (categoryIndex) {
        case 0: // 한식
          filteredStoreData = _allStores
              .where((store) => store['category'] == '한식')
              .toList();
          break;
        case 1: // 일식
          filteredStoreData = _allStores
              .where((store) => store['category'] == '일식')
              .toList();
          break;
        case 2: // 중식
          filteredStoreData = _allStores
              .where((store) => store['category'] == '중식')
              .toList();
          break;
        case 3: // 치킨
          filteredStoreData = _allStores
              .where((store) => store['category'] == '치킨')
              .toList();
          break;
        case 4: // 피자
          filteredStoreData = _allStores
              .where((store) => store['category'] == '피자')
              .toList();
          break;
        case 5: // 아시아
          filteredStoreData = _allStores
              .where((store) => store['category'] == '아시아')
              .toList();
          break;
        case 6: // 멕시칸
          filteredStoreData = _allStores
              .where((store) => store['category'] == '멕시칸')
              .toList();
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
          return _Image(
            storeImg, // 이미지 URL
            storeName, // 스토어 이름
          );
        }),
      );
    }
  }
}

// 하트 아이콘

//하트아이콘 기능 정의
class HeartIconButton extends StatefulWidget {
  @override
  _HeartIconButtonState createState() => _HeartIconButtonState();
}

class _HeartIconButtonState extends State<HeartIconButton> {
  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isFilled
          ? Icon(Icons.favorite, color: Colors.red)
          : Icon(Icons.favorite_border, color: Colors.white),
      onPressed: () {
        setState(() {
          isFilled = !isFilled;
        });
      },
    );
  }
}
