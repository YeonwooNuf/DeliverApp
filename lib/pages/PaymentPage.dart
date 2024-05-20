import 'package:flutter/material.dart';
import 'PaymentMethod.dart';

void main() => runApp(MyApp());

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

  void _showPaymentMethods() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(

          height: 200,

          height: screenWidth * 0.3,

          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('신용/체크카드'),
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = '신용/체크카드';
                  });
                  Navigator.pop(context);
                  _showCreditCardOptions(); // 새로운 드롭다운 메뉴 표시
                },
              ),
              ListTile(
                title: Text('계좌이체'),
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = '계좌이체';
                  });
                  Navigator.pop(context);
                  _showCreditCardOption(); // 새로운 드롭다운 메뉴 표시
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCreditCardOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(

          height: 200,
          height: screenWidth * 0.3,

          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.credit_card), // 여기에 아이콘 추가
                title: Text('KB국민카드 ****932*'),
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 'KB국민카드 ****932*';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.credit_card), // 여기에 아이콘 추가
                title: Text('신한카드 ****956*'),
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = '신한카드 ****956*';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCreditCardOption() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(

          height: 200,
          height: screenWidth * 0.3,

          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.credit_card), // 여기에 아이콘 추가
                title: Text('KB Pay'),
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = 'KB PAY';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.credit_card), // 여기에 아이콘 추가
                title: Text('카카오페이'),
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = '카카오페이';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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

          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('집 (으)로 배달', style: TextStyle(fontSize: screenWidth * 0.05)),
              Center(
                child: Text(
                  '미추홀구 경인남길\n102번길 59-14',
                  style: TextStyle(fontSize: screenWidth * 0.07),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenWidth * 0.05),
              Text('시장을 여는 사람들 인하대점', style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold)),

              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 0),

                child: Text('[2~3인 뼈없는 감자탕]', style: TextStyle(fontSize: 20)),

                child: Text('[2~3인 뼈없는 감자탕]', style: TextStyle(fontSize: screenWidth * 0.06)),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,

                      borderRadius: BorderRadius.circular(20),

                      borderRadius: BorderRadius.circular(screenWidth * 0.04),

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
              Text('18,900원', style: TextStyle(fontSize: screenWidth * 0.06)),

              Divider(
                color: Colors.grey,
                thickness: 1,
              ),

              SizedBox(height: 16),

              SizedBox(height: screenWidth * 0.05),

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

              SizedBox(height: screenWidth * 0.05),

              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,

                padding: EdgeInsets.all(10),

                padding: EdgeInsets.all(screenWidth * 0.025),

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

                      style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Text(
                      '가게 사장님에게',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              Center(
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenWidth * 0.1,

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

                      filled : true,
                      fillColor: Color.fromARGB(255, 241, 239, 239),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: screenWidth * 0.04),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.04),

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

                      style: TextStyle(fontSize: screenWidth * 0.032),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: screenWidth * 0.08),
                child: Text(
                  '일회용품 사용을 줄이기 위해, 선택 시에만 제공됩니다.',
                  style: TextStyle(fontSize: screenWidth * 0.012, color: Colors.grey),
                ),
              ),
              SizedBox(height: screenWidth * 0.02),

              GestureDetector(
                onTap: () {
                  _showSimpleDialog();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
 
                  padding: EdgeInsets.all(10),

                  padding: EdgeInsets.all(screenWidth * 0.025),

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

                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.02),
              SizedBox(height: screenWidth * 0.02),
              Center(
                child: Container(
                  width: screenWidth * 0.6,

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

              GestureDetector(
                // GestureDetector를 사용하여 리스트를 클릭할 수 있게 함

              GestureDetector( // GestureDetector를 사용하여 리스트를 클릭할 수 있게 함

                onTap: () {
                  _showPaymentMethods(); // 결제 수단 표시
                },
                child: Container(
                  alignment: Alignment.centerLeft,

                  padding: EdgeInsets.all(10),

                  padding: EdgeInsets.all(screenWidth * 0.025),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '결제 수단',

                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$_selectedPaymentMethod', // 선택된 결제 수단 표시
                        style: TextStyle(fontSize: 16),

                        style: TextStyle(fontSize: screenWidth * 0.032, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenWidth * 0.02,),
                      Text(
                        '$_selectedPaymentMethod', // 선택된 결제 수단 표시
                        style: TextStyle(fontSize: screenWidth * 0.032),

                      ),
                    ],
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

        height: screenHeight * 0.1,

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

            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold), // 버튼의 글씨색을 흰색으로 변경
          ),
        ),
      ),
    );
  }

  _showSimpleDialog() {
    // Add your simple dialog logic here
  }
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
}
