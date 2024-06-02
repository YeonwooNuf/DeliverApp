import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery/pages/address/AddressInfo.dart';

class AddressSearch extends StatefulWidget {
  @override
  _AddressSearchState createState() => _AddressSearchState();
}

class _AddressSearchState extends State<AddressSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  String _errorMessage = '';
  Timer? _debounce;
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        _page = 1;
        _searchResults.clear();
        _hasMore = true;
        _searchAddress();
      } else {
        setState(() {
          _searchResults = [];
          _errorMessage = '';
        });
      }
    });
  }

  bool _isValidAddress(String address) {
    // 번지수가 있는지 검사하는 정규 표현식
    RegExp regExp = RegExp(r'\d+$');
    return regExp.hasMatch(address);
  }

  Future<void> _searchAddress() async {
    if (_isLoading || !_hasMore) return;

    final String query = _searchController.text;
    final String kakaoApiKey = '36dd18863873333499460d1f9f5cd30c';
    final String apiUrl =
        'https://dapi.kakao.com/v2/local/search/address.json?query=$query&page=$_page&size=15';

    setState(() {
      _isLoading = true;
    });

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'KakaoAK $kakaoApiKey',
        },
      );

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        final List<dynamic> addresses = data['documents'];

        setState(() {
          _searchResults.addAll(addresses.map<String>((dynamic item) {
            if (item['road_address'] != null) {
              return item['road_address']['address_name'] as String;
            } else if (item['address'] != null) {
              return item['address']['address_name'] as String;
            } else {
              return '주소 정보 없음';
            }
          }).toList());
          _hasMore = addresses.length == 15;
          _errorMessage = '';
          _page++;
        });
        print('API 연결 성공: ${_searchResults.length}개의 결과를 찾았습니다.');
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode} ${response.reasonPhrase}';
        });
        print('API 연결 실패: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error occurred while fetching data: $e';
      });
      print('Error occurred while fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;
    _searchAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '주소 설정',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '도로명, 건물명 또는 지번으로 검색하세요',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchAddress,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    textStyle: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  child: Text('검색',),
                ),
              ],
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Divider(height: 5, color: Colors.grey),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '검색 Tip :',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '1. 정확한 도로명 또는 건물명(번호)을 입력하세요.\n'
                '2. 지번 주소를 사용할 경우, 시, 구, 동까지 입력해 주세요.\n'
                '3. 동/읍/면/리 + 번지 수를 같이 입력해주세요.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      !_isLoading) {
                    _loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _searchResults.length - 1 && _isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListTile(
                      title: Text(_searchResults[index]),
                      onTap: () {
                        if (_isValidAddress(_searchResults[index])) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressInfo(
                                searchedAddress: _searchResults[index],
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            _errorMessage = '건물번호가 포함된 도로명주소를 입력해 주세요.';
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
