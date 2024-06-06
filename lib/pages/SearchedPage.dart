import 'package:delivery/pages/MenuSearchPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchedPage extends StatefulWidget {
  final String keyword;

  SearchedPage({required this.keyword});

  @override
  _SearchedPageState createState() => _SearchedPageState();
}

class _SearchedPageState extends State<SearchedPage> {
  List<dynamic> searchResults = [];
  Map<int, dynamic> storeMap = {};
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    search(widget.keyword);
  }

  Future<void> search(String keyword) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/search?keyword=$keyword'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      print('서버 응답: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          searchResults = json.decode(utf8.decode(response.bodyBytes));
          isLoading = false;
          // 각 메뉴의 가게 ID를 추출하여 해당 가게 정보를 가져오는 메서드 호출
          for (var menu in searchResults) {
            final storeId = menu['menuStoreIdStoreId'];
            if (storeId != null && !storeMap.containsKey(storeId)) {
              fetchStoreInfo(storeId);
            }
          }
        });
      } else {
        setState(() {
          errorMessage = '검색 결과를 불러오는 데 실패했습니다. 상태 코드: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = '검색을 수행하는 동안 오류가 발생했습니다: $e';
        isLoading = false;
      });
    }
  }

  // 가게 정보 가져오는 메서드
  Future<void> fetchStoreInfo(int storeId) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/store/$storeId'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        final storeInfo = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          storeMap[storeId] = storeInfo;
        });
      } else {
        print('가게 정보를 불러오는 데 실패했습니다. 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('가게 정보를 불러오는 동안 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과: ${widget.keyword}'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(child: Text('검색 결과가 없습니다.'));
    }

    return ListView.builder(
      itemCount: storeMap.length,
      itemBuilder: (context, index) {
        final storeId = storeMap.keys.elementAt(index);
        final storeInfo = storeMap[storeId];
        return _buildStoreCard(storeInfo);
      },
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> storeInfo) {
    final String storeName = storeInfo['storeName'] ?? '가게 이름 없음';
    final String storeImageUrl =
        storeInfo['storeImg'] ?? 'https://via.placeholder.com/150';
    final int storeId = storeInfo['storeId'];
    final String storeAddress = storeInfo['storeAddress'] ?? '주소정보 없음';

    return Padding(
      padding: const EdgeInsets.all(20),
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
                        storeImage_URL: storeImageUrl,
                        storeName: storeName,
                        storeId: storeId,
                        storeAddress: storeAddress,
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
                      storeImageUrl,
                      fit: BoxFit.cover,
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
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              storeName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
