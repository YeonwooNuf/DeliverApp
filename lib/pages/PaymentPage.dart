import 'package:flutter/material.dart';
import 'PaymentMethod.dart';
import 'package:delivery/pages/address/AddressChange.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemListNotifier()..fetchProducts()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int quantity = 1;
  bool isDisposableChecked = false;
  String? _selectedItem = '직접 받을게요 (부재 시 문 앞)';
  String? _selectedPaymentMethod = '결제 수단을 선택해주세요.';

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _addMenu() {
    print("메뉴 추가가 클릭되었습니다.");
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      isDisposableChecked = value ?? false;
    });
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
                  '미추홀구 경인남길\n102번길 59-14',
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              Text('시장을 여는 사람들 인하대점',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 0),
                child: Text('[2~3인 뼈없는 감자탕]', style: TextStyle(fontSize: 20)),
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
                          onPressed: _decreaseQuantity,
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: _increaseQuantity,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text('18,900원', style: TextStyle(fontSize: 20)),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(height: 16),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _addMenu,
                  child: Text('+메뉴 추가'),
                ),
              ),
              SizedBox(height: 16),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '요청사항',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '가게 사장님에게',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Container(
                  width: 380,
                  height: 40,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: '예) 견과류는 빼주세요',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Color.fromARGB(255, 241, 239, 239),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                  ),
                ),
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
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // 버튼을 클릭했을 때 실행할 내용을 여기에 작성하세요.
            TotalPayment().bootpayTest(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // 버튼의 배경색을 파란색으로 변경
            padding: EdgeInsets.symmetric(vertical: 0), // 버튼의 수직 패딩 추가
          ),
          child: Text(
            '18,900원 결제하기',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold), // 버튼의 글씨색을 흰색으로 변경
          ),
        ),
      ),
    );
  }

  _showSimpleDialog() {
    // Add your simple dialog logic here
  }
}
