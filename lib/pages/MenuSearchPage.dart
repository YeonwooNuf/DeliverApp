import 'package:delivery/pages/PaymentPage.dart';
import 'package:delivery/service/sv_menu.dart';
import 'package:flutter/material.dart';

class MenuSearchPage extends StatefulWidget {
  final String storeImage_URL;
  final String storeName;
  final int storeId;
  final String storeAddress;

  MenuSearchPage(
      {required this.storeImage_URL,
      required this.storeName,
      required this.storeId,
      required this.storeAddress});

  @override
  _MenuSearchPageState createState() => _MenuSearchPageState();
}

class _MenuSearchPageState extends State<MenuSearchPage> {
  late List<Map<String, dynamic>> _filteredMenus = [];
  bool _isPaymentButtonVisible = false;
  int _selectedQuantity = 1;
  int _totalPrice = 0;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  // 이미지 부분
                  height:
                      MediaQuery.of(context).size.height * 0.32, // 화면의 높이 32%
                  child: Image.network(
                    widget.storeImage_URL,
                    fit: BoxFit.fill, // 이미지를 컨테이너에 맞춤
                    width: double.infinity, // 이미지가 컨테이너에 가득 차도록 가로 너비를 확장
                    height: double.infinity, // 이미지가 컨테이너에 가득 차도록 세로 너비를 확장
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height *
                      0.25, // 화면의 높이 25%에 위치
                  left: MediaQuery.of(context).size.width *
                      0.04, // 왼쪽 여백을 화면의 너비를 기준으로 설정
                  right: MediaQuery.of(context).size.width *
                      0.04, // 오른쪽 여백을 화면의 너비를 기준으로 설정
                  child: Container(
                    height:
                        MediaQuery.of(context).size.height * 0.1, // 화면의 높이 10%
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.3),
                          offset: const Offset(0, 3),
                          blurRadius: 5.0,
                        )
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white70,
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
              height: MediaQuery.of(context).size.height * 0.05, // 화면의 높이 5%
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 2.0), // 굵은 검은색 테두리 추가
                color: Colors.transparent, // 내부 배경색을 투명하게 설정
              ),
              child: Padding(
                padding: EdgeInsets.only(right: 16.0), // 오른쪽 여백 추가
                child: Align(
                  child: Text(
                    '${widget.storeAddress}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(221, 33, 33, 33)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // 리뷰 텍스트의 위치를 약간 띄움
            Padding(
              padding: EdgeInsets.only(left: 16.0), // 왼쪽 여백 추가
              child: Container(
                height: MediaQuery.of(context).size.height * 0.03,
                alignment: Alignment.centerLeft,
                child: Text(
                  '리뷰',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
  padding: EdgeInsets.all(20),
  child: Container(
    height: MediaQuery.of(context).size.height * 0.15, // 리뷰 박스 높이 설정
    child: ListView.builder(
      scrollDirection: Axis.horizontal, // 가로 스크롤
      itemCount: 3, // 리뷰 박스 개수 (예시로 3개)
      itemBuilder: (context, index) {
        return Row(
          children: [
            _ReviewBox(context),
            SizedBox(width: 20), // 간격 추가
          ],
        );
      },
    ),
  ),
),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0)),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "전체 메뉴",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              physics:
                  NeverScrollableScrollPhysics(), // Disable scrolling of the ListView
              shrinkWrap: true, // Take only necessary space
              itemCount: _filteredMenus.length,
              itemBuilder: (context, index) {
                return _MenuBox(_filteredMenus[index]);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _isPaymentButtonVisible
          ? GestureDetector(
              onTap: () {
                // 결제하기 버튼 클릭 시 실행할 기능 추가
                _goToPaymentPage(selectedMenus);
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '${_totalPrice}원 결제하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(), // 결제하기 버튼이 보이지 않을 때는 빈 SizedBox를 반환하여 영역을 차지하지 않도록 함
    );
  }

  Widget _MenuBox(Map<String, dynamic> menu) {
    return GestureDetector(
      onTap: () {
        _showQuantityDialog(menu);
      },
      child: Container(
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
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    menu['productName'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${menu['price']} 원',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //메뉴 수량 선택기능 구현
  List<Map<String, dynamic>> selectedMenus = [];

  void _showQuantityDialog(Map<String, dynamic> menu) {
    int quantity = 1; // 초기 수량

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                '수량 선택',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  },
                ),
                Text(
                  quantity.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      if (quantity < 10) {
                        quantity++;
                      }
                    });
                  },
                ),
                TextButton(
                  onPressed: () {
                    int price = menu['price'] as int;
                    int totalPrice = quantity * price; // 선택된 수량에 메뉴 가격을 곱한 값

                    // 이미 선택된 메뉴가 리스트에 있는지 확인
                    bool isExist = false;
                    for (var item in selectedMenus) {
                      if (item['productName'] == menu['productName']) {
                        isExist = true;
                        item['quantity'] += quantity; // 기존 수량에 추가
                        item['totalPrice'] += totalPrice; // 총 가격 업데이트
                        break;
                      }
                    }

                    // 선택된 메뉴가 리스트에 없는 경우, 새로 추가
                    if (!isExist) {
                      selectedMenus.add({
                        'productName': menu['productName'],
                        'price': price,
                        'quantity': quantity,
                        'totalPrice': totalPrice,
                      });
                    }

                    // 다이얼로그 닫기 및 총합 업데이트
                    int totalSum = selectedMenus.fold(
                        0, (sum, item) => sum + item['totalPrice'] as int);
                    Navigator.of(context).pop(totalSum);
                  },
                  child: Text(
                    '확인',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((totalSum) {
      if (totalSum != null) {
        setState(() {
          _isPaymentButtonVisible = true; // 결제하기 버튼을 보이도록 설정
          _totalPrice = totalSum; // 선택된 메뉴의 총 가격을 저장
        });
      }
    });
  }

  // 결제하기 버튼 클릭 시 실행되는 함수
  void _goToPaymentPage(List<Map<String, dynamic>> selectedMenus) async {
    // PaymentPage로 이동하여 데이터 전달
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          selectedStoreId: widget.storeId,
          selectedStoreName: widget.storeName,
          selectedMenus: selectedMenus,
          storeAddress: widget.storeAddress,
        ),
      ),
    ).then((result) {
      // 결과값을 확인하고 페이지를 새로고침
      if (result == true) {
        setState(() {
          _isPaymentButtonVisible = false;
          _totalPrice = 0;
        });
      }
    });
  }

  //리뷰박스 ui
  Widget _ReviewBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // 회색 테두리 추가
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: 10, top: 10, bottom: 10, right: 175), // 왼쪽 여백 추가
        child: Container(
          width: MediaQuery.of(context).size.height * 0.01,
          height: MediaQuery.of(context).size.height * 0.01,
          color: Colors.black,
        ),
      ),
    );
  }
}
