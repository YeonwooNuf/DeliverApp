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
      body: Container(
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
                      0.2, // 화면의 높이 20%에 위치
                  left: MediaQuery.of(context).size.width *
                      0.04, // 왼쪽 여백을 화면의 너비를 기준으로 설정
                  right: MediaQuery.of(context).size.width *
                      0.04, // 오른쪽 여백을 화면의 너비를 기준으로 설정
                  child: Container(
                    height:
                        MediaQuery.of(context).size.height * 0.1, // 화면의 높이 10%
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
            Container(
              height: MediaQuery.of(context).size.height * 0.1, // 화면의 높이 30%
              color: Colors.blue,
              child: Text('${widget.storeAddress}'),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  _ReviewBox(context),
                  SizedBox(width: 20), // 간격 추가
                  _ReviewBox(context),
                  SizedBox(width: 20), // 간격 추가
                  _ReviewBox(context), //여기에 리뷰 리스트 뜨게 해야함 리뷰함수 만들어서 구현 ㄱㄱ
                ]),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: Center(
                child: Text(
                  "메뉴",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _isPaymentButtonVisible
                      ? GestureDetector(
                          onTap: () {
                            // 결제하기 버튼 클릭 시 실행할 기능 추가
                            _goToPaymentPage(selectedMenus);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
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
                ),
              ],
            ),
          ],
        ),
      ),
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
                // 수량 감소 버튼
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
                // 수량 증가 버튼
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
                // 확인 버튼 눌렀을 때
                TextButton(
                  onPressed: () {
                    int price = menu['price'] as int;
                    int totalSum =
                        _totalPrice + (quantity * price); // 선택된 수량에 메뉴 가격을 곱한 값
                    int totalPrice = (quantity * price); // 선택된 수량에 메뉴 가격을 곱한 값
                    setState(() {
                      // 선택된 메뉴의 정보를 리스트에 추가
                      selectedMenus.add({
                        'productName': menu['productName'],
                        'price': price,
                        'quantity': quantity,
                        'totalPrice': totalPrice,
                      });
                    });
                    Navigator.of(context).pop(totalSum); // 다이얼로그 닫기
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
      // 다이얼로그가 닫힌 후 실행되는 로직
      if (totalSum != null) {
        // 선택된 메뉴의 총 가격이 null이 아닌 경우에만 실행
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
  ).then((result){
    // 결과값을 확인하고 페이지를 새로고침
  if (result == true) {
    setState(() {
      _isPaymentButtonVisible = false;
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
