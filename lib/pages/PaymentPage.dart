import 'package:delivery/pages/MenuSearchPage.dart';
import 'package:flutter/material.dart';
import 'PaymentMethod.dart';
import 'package:delivery/AddressChange.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final int selectedStoreId;
  final String selectedStoreName;
  final List<Map<String, dynamic>> selectedMenus;
  final String storeAddress;

  PaymentPage({
    required this.selectedStoreId,
    required this.selectedStoreName,
    required this.selectedMenus,
    required this.storeAddress
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
    // 초기 메뉴 데이터 콘솔 출력
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

  @override
  Widget build(BuildContext context) {
    int totalPrice = getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
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
              Text('집 (으)로 배달', style: TextStyle(fontSize: 18)),
              Center(
                child: Text(
                  '${widget.storeAddress}',
                  style: TextStyle(fontSize: 28),
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text(
                          menu['productName'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      if (menu['quantity'] > 1) {
                                        menu['quantity']--;
                                        menu['totalPrice'] = menu['price'] * menu['quantity'];
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '${menu['quantity']}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      if(menu['quantity'] <10){
                                      menu['quantity']++;
                                      menu['totalPrice'] = menu['price'] * menu['quantity'];
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${menu['totalPrice']}원',
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ],
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
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  _showSimpleDialog();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '배달 기사님에게',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0),
              SizedBox(height: 0),
              Center(
                child: Container(
                  width: 230,
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
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // 버튼을 클릭했을 때 실행할 내용을 여기에 작성하세요.
            TotalPayment().bootpayTest(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 0),
          ),
          child: Text(
            '${totalPrice}원 결제하기',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _showSimpleDialog() {
    // Add your simple dialog logic here
  }
}
