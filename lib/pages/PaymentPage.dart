import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'PaymentMethod.dart';

class PaymentPage extends StatefulWidget {
  final int selectedStoreId;
  final String selectedStoreName;
  final List<Map<String, dynamic>> selectedMenus;
  final String storeAddress;
  final String userNumber;

  PaymentPage({
    required this.selectedStoreId,
    required this.selectedStoreName,
    required this.selectedMenus,
    required this.storeAddress,
    required this.userNumber,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isDisposableChecked = false;
  String? _selectedItem = '직접 받을게요 (부재 시 문 앞)';

  @override
  void initState() {
    super.initState();
    print('Initial Menus: ${widget.selectedMenus}');
  }

  int getTotalPrice() {
    int total = 0;
    for (var menu in widget.selectedMenus) {
      total += menu['totalPrice'] as int;
    }
    return total;
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      isDisposableChecked = value ?? true;
    });
  }

void _sendOrderToServer() async {
    int total = getTotalPrice();
    List<String> productNames = widget.selectedMenus
    .map((menu) => menu['productName'] as String?) // 'productName'이 없을 경우 null 반환
    .where((productName) => productName != null) // null이 아닌 값만 필터링
    .cast<String>() // null이 없는 것으로 보장하기 위해 명시적으로 형변환
    .toList();

     print('Product Names: $productNames'); // Product Names 출력
    // 서버로 전송할 데이터
    var orderData = {
      'storeId': widget.selectedStoreId,
      'storeName': widget.selectedStoreName,
      'productNames': productNames,
      'storeAddress': widget.storeAddress,
      'totalPrice': total,
      'userNumber': widget.userNumber,
      // 기타 필요한 데이터 추가
    };

    // 데이터를 JSON 형식으로 변환
    var body = jsonEncode(orderData);

    // POST 요청 보내기
    var response = await http.post(
      Uri.parse('http://localhost:8080/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    // 응답 확인
    if (response.statusCode == 200) {
      print('주문내역이 성공적으로 전송되었습니다.');
      // 여기서 필요한 처리를 수행하세요.
    } else {
      print('주문내역 전송에 실패했습니다.');
      // 실패 시에 대한 처리를 수행하세요.
    }
  }

  @override
  Widget build(BuildContext context) {
    int payTotalPrice = getTotalPrice();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            setState(() {
              widget.selectedMenus.clear();
            });
            Navigator.pop(context, true);
          },
        ),
        title: Text(
          '배달',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '집 (으)로 배달',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  '${widget.storeAddress}',
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.selectedStoreName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Column(
                children: widget.selectedMenus.map((menu) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu['productName'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.remove,
                                          color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          if (menu['quantity'] > 1) {
                                            menu['quantity']--;
                                            menu['totalPrice'] = menu['price'] *
                                                menu['quantity'];
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      '${menu['quantity']}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.add, color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          if (menu['quantity'] < 10) {
                                            menu['quantity']++;
                                            menu['totalPrice'] = menu['price'] *
                                                menu['quantity'];
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${menu['totalPrice']}원',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Checkbox(
                      value: isDisposableChecked,
                      onChanged: _handleCheckboxChange,
                    ),
                    Text(
                      '일회용 수저/포크 받기',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  '일회용품 사용을 줄이기 위해, 선택 시에만 제공됩니다.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: screenWidth * 0.8,
                  child: DropdownButton<String>(
                    value: _selectedItem,
                    items: <String>[
                      '직접 받을게요 (부재 시 문 앞)',
                      '문 앞에 놔주세요 (초인종 O)',
                      '문 앞에 놔주세요 (초인종 X)',
                      '도착하면 전화해주세요',
                      '도착하면 문자해주세요'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                    },
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height:
            MediaQuery.of(context).size.height * 0.18, // 높이를 버튼 두 개가 들어갈 정도로 조절
        decoration: BoxDecoration(
          color: Colors.white, // 배경색을 흰색으로 설정
          borderRadius: BorderRadius.circular(20), // 둥글게 설정
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // 두 번째 버튼의 동작을 정의합니다.
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A82FF), // 버튼의 배경색
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 버튼도 둥글게 설정
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
              ),
              child: Text(
                '환율 계산',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _sendOrderToServer(); // _sendOrderToServer 함수 호출
                TotalPayment().bootpayTest(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 버튼도 둥글게 설정
                ),
                padding: EdgeInsets.symmetric(horizontal: 20,  vertical: 23),
              ),
              child: Text(
                '${payTotalPrice}원 결제하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
