import 'package:delivery/pages/PaymentMethod.dart';
import 'package:delivery/service/sv_ExchangeRate.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final int selectedStoreId;
  final String selectedStoreName;
  final List<Map<String, dynamic>> selectedMenus;
  final String storeAddress;
  List<ExchangeRate> exchangeRates = []; // 환율 데이터를 담을 리스트

  PaymentPage({
    required this.selectedStoreId,
    required this.selectedStoreName,
    required this.selectedMenus,
    required this.storeAddress,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isDisposableChecked = false;
  String? _selectedItem = '직접 받을게요 (부재 시 문 앞)';
  String? dropdownValue = ''; // 드롭다운 메뉴에서 선택된 값
  List<String> ttbValues = []; // ttb 값을 저장할 리스트

  @override
  void initState() {
    super.initState();
    print('Initial Menus: ${widget.selectedMenus}');
    _loadExchangeRates(); // initState에서 환율 데이터를 가져옴
  }

  // 환율 데이터를 가져와서 exchangeRates에 할당
  void _loadExchangeRates() async {
    try {
      final rates = await getExchangeRate();
      //_loadExchangeRates 함수가 데이터를 로드한 후 setState를 호출하여 UI를 갱신
      setState(() {
        widget.exchangeRates = rates;

        if (widget.exchangeRates.isNotEmpty) {
          dropdownValue = widget.exchangeRates[13].curUnit; //리스트 초기값 설정(KRW)
        }
        //ttb값 리스트를 가져옴.
        ttbValues = rates.map((exchangeRate) => exchangeRate.ttb).toList();
      });
    } catch (e) {
      print('Failed to load exchange rates: $e');
    }
  }

//한국돈 결제 금액 함수
  double getKoreanTotalPrice() {
    double totalKoreanPrice = 0;
    for (var menu in widget.selectedMenus) {
      totalKoreanPrice += menu['totalPrice'] as int;
    }
    return totalKoreanPrice;
  }


  //결제할 금액을 환율에 따라 변경
  double calculateTotalPriceWithTtb(double totalPrice, String? selectedUnit) {
    if (selectedUnit == null) return totalPrice; // 선택된 단위가 없으면 그대로 반환

    // 선택된 단위의 ttb 값을 찾아서 totalPrice와 총 가격 계산
    final index =
        widget.exchangeRates.indexWhere((rate) => rate.curUnit == selectedUnit);

    if (index != -1) {
      String ttbString = widget.exchangeRates[index].ttb;
      ttbString = ttbString.replaceAll(',', '');
      double ttb = double.tryParse(ttbString) ?? 1.0;
      // 한국 돈은 ttb가 0이므로 1로 치환하여 계산함.
      switch (ttb) {
        case 0:
          ttb = 1;
          break;
        default:
        // 다른 경우에 대한 처리
      }

      final calculatedPrice = totalPrice / ttb;
      return double.parse(calculatedPrice.toStringAsFixed(2)); // 소수점 두 자리까지 표현
    }

    return totalPrice;
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      isDisposableChecked = value ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double payKoreanTotalPrice = getKoreanTotalPrice();// 연우야 이게 결제api쓸때 사용할 한국돈 결제 금액임
    print('한국 돈 결제 금액: $payKoreanTotalPrice');
    double payTotalPrice = calculateTotalPriceWithTtb(payKoreanTotalPrice, dropdownValue);
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
            MediaQuery.of(context).size.height * 0.1, // 높이를 버튼 두 개가 들어갈 정도로 조절
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // 둥글게 설정
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                TotalPayment().bootpayTest(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 버튼도 둥글게 설정
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
              ),
              child:Row(
  mainAxisAlignment: MainAxisAlignment.center, // 수평 방향으로 중앙 정렬
  children: [
    Expanded(
      child: Container(
        width: screenWidth * 0.01,
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(
            Icons.arrow_drop_down,
            size: 30,
            color: Colors.white,
          ),
          iconSize: 20,
          elevation: 16,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          underline: Container(
            height: 0,
            color: Colors.transparent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
            // 드롭다운 메뉴에서 선택된 값에 따라 동작을 정의
          },
          items: widget.exchangeRates.map((ExchangeRate exchangeRate) {
            return DropdownMenuItem<String>(
              value: exchangeRate.curUnit,
              child: Center(
                child: Text(
                  exchangeRate.curUnit,
                  style: TextStyle(
                    color: dropdownValue == exchangeRate.curUnit
                        ? Colors.white
                        : Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ),
    SizedBox(width: 20,),
    
     Text(
        '${payTotalPrice}${dropdownValue} 결제하기',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    
  ],
),


            ),
          ],
        ),
      ),
    );
  }
}
