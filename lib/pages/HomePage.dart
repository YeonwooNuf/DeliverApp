import 'package:delivery/category/CategorySelect.dart';
import 'package:delivery/pages/SearchPage.dart';
import 'package:flutter/material.dart';

import 'package:delivery/pages/address/AddressRegisterPage.dart';
import 'package:delivery/service/sv_ExchangeRate.dart';
import 'package:delivery/AddressChange.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 216, 214, 214),
        fontFamily: "MangoDdobak",
        textTheme: TextTheme(
      // 여기에서 모든 텍스트 스타일을 변경합니다.
      bodyText1: TextStyle(fontWeight: FontWeight.w700), // 예시로 bodyText1을 변경하였습니다. 필요에 따라 다른 스타일도 변경할 수 있습니다.
      bodyText2: TextStyle(fontWeight: FontWeight.w700),
      // 추가적으로 필요한 스타일이 있다면 여기에 추가합니다.
    ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드로 인한 화면 크기 조정 방지
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: const HomeScreen(selectedIndex: 0),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  const HomeScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String? homeAddress = Provider.of<ItemListNotifier>(context).homeAddress;
    // String? workAddress = Provider.of<ItemListNotifier>(context).workAddress;
    // List<String> addresses = Provider.of<ItemListNotifier>(context).addresses;

    String selectedAddress = '';
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isExpanded = true;

  String selectedAddress = '';

          String? addressType = Provider.of<ItemListNotifier>(context).addressType;

      return SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.all(8), // 좌측에 여백 추가
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft, // 왼쪽 정렬
                child: TextButton(
                  onPressed: () {
                    // Add your desired logic here
                    // For example, you can navigate to a new page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressRegisterPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Row의 크기를 내용물에 맞게 조정
                    children: [
                      Icon(Icons.location_on, color: Colors.black),
                      SizedBox(width: 8), // 아이콘과 텍스트 사이에 간격 추가
                      Text(
                        addressType, // Add the selected address value here
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    ],
                  ),
  String _getSelectedAddressName(BuildContext context) {
    final itemListNotifier = Provider.of<ItemListNotifier>(context);

    switch (itemListNotifier.selectedIndex) {
      case -2:
        selectedAddress = itemListNotifier.homeAddress ?? '집 주소가 없습니다.';
        break;
      case -1:
        selectedAddress = itemListNotifier.workAddress ?? '회사 주소가 없습니다.';
        break;
      default:
        selectedAddress = itemListNotifier.addresses[itemListNotifier.selectedIndex] ?? '기타 주소가 없습니다.';
        break;
    }

    String selectedAddressPrefix = selectedAddress.length >= 5
        ? selectedAddress.substring(0, 5)
        : selectedAddress;
    return selectedAddressPrefix;
  }

  Widget _appBar() {
    String selectedAddress = Provider.of<ItemListNotifier>(context).selectedAddress;

    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(8), // 좌측에 여백 추가
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft, // 왼쪽 정렬
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressRegisterPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Row의 크기를 내용물에 맞게 조정
                  children: [
                    Icon(Icons.location_on, color: Colors.black,),
                    SizedBox(width: 8), // 아이콘과 텍스트 사이에 간격 추가
                    Text(
                      selectedAddress, // Add the selected address value here
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Color(0xFF0892D0)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8), // 주소와 검색창 사이 간격 추가
            Container(
              height: 60,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.3),
                    offset: const Offset(0, 3),
                    blurRadius: 5.0,
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: TextField(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ),
                            );
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "  검색어를 입력해주세요",
                            hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 18,
                              fontFamily: "MangoDdobak"), // Pretendard 글꼴 설정 // 힌트 텍스트의 글씨 크기 조절
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
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

    // 카테고리 정의하는 메서드
    Widget _roundedContainer(String image, String title, VoidCallback onTap) {
      double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30), // 컨테이너의 모서리를 둥글게 설정
                ),
                width: squareSize,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    image,
                    width: squareSize,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      );
    }

    // 환율 이미지, 값 정의하는 함수
    Widget exchangeRateImage(String imagePath, String firstText,
        String secondText, double screenHeight, double screenWidth) {
      return Container(
        height: screenHeight * 0.1,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.25,
  Widget _roundedContainer(String image, String title, VoidCallback onTap) {
    double squareSize = (MediaQuery.of(context).size.width - 60) / 4;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30), // 컨테이너의 모서리를 둥글게 설정
              ),
              width: squareSize,
              height: squareSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  image,
                  width: squareSize,
                  height: squareSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget exchangeRateImage(String imagePath, String firstText,
      String secondText, double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.1,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              height: screenHeight * 0.07,
              width: screenWidth * 0.25,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.025,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  firstText,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  secondText,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

    // 환율 데이터를 가져오는 FutureBuilder 사용
    Widget _exchangeRateContents(double screenHeight, double screenWidth) {
      return FutureBuilder<List<ExchangeRate>>(
        future: getExchangeRate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final exchangeRates = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true, // 부모의 크기에 맞춰 스크롤 크기를 조정
              itemCount: exchangeRates.length,
              itemBuilder: (context, index) {
                final exchangeRate = exchangeRates[index];
                return exchangeRateImage(
                  'assets/images/country/${exchangeRate.curUnit}.png',
                  '${exchangeRate.curUnit}-${exchangeRate.curName}',
                  '1${exchangeRate.curUnit} - ${exchangeRate.ttb}원',
                  screenHeight,
                  screenWidth,
                );
              },
            );
          }
        },
      );
    }

    Widget _contents() {
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      return Expanded(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _roundedContainer('assets/images/bibimbap.jpeg', '한식',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '한식')),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/sushi.jpeg', '일식',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '일식')),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/jjajang.jpeg', '중식',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '중식')),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/chicken.jpeg', '치킨',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '치킨')),
                            );
                          }),
                        ],
  Widget _exchangeRateContents(double screenHeight, double screenWidth) {
    return FutureBuilder<List<ExchangeRate>>(
      future:  getExchangeRate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final exchangeRates = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true, // 부모의 크기에 맞춰 스크롤 크기를 조정
            itemCount: exchangeRates.length,
            itemBuilder: (context, index) {
              final exchangeRate = exchangeRates[index];
              return exchangeRateImage(
                'assets/images/country/${exchangeRate.curUnit}.png',
                '${exchangeRate.curUnit}-${exchangeRate.curName}',
                '1${exchangeRate.curUnit} - ${exchangeRate.ttb}원',
                screenHeight,
                screenWidth,
              );
            },
          );
        }
      },
    );
  }

  Widget _contents() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          _roundedContainer('assets/images/pizza.jpeg', '피자',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '피자')),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/pho.jpeg', '아시아',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '아시아')),
                            );
                          }),
                          SizedBox(width: 8),
                          _roundedContainer('assets/images/burrito.jpeg', '멕시칸',
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategorySelect(CategoryName: '멕시칸')),
                            );
                          }),
                          SizedBox(width: 8),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                          color: Color(0xFF004AAD),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0), // 왼쪽 위 모서리 둥글게
                            topRight: Radius.circular(20.0), // 오른쪽 위 모서리 둥글게
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '실시간 환율(KRW)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.6,
                        child: ClipRRect(
                          // ClipRRect를 사용하여 모서리를 둥글게 만듭니다.
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0), // 아래 모서리 둥글게
                            bottomRight: Radius.circular(20.0), // 아래 모서리 둥글게
                          ),
                          child:
                              _exchangeRateContents(screenHeight, screenWidth),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
                          Row(
                            children: [
                              _roundedContainer('assets/images/bibimbap.png', '한식', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategorySelect(CategoryName: '한식')),
                                );
                              }),
                              SizedBox(width: 8),
                              _roundedContainer('assets/images/Japanese.png', '일식/돈까스', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategorySelect(CategoryName: '일식/돈까스')),
                                );
                              }),
                              SizedBox(width: 8),
                              _roundedContainer('assets/images/Chinese.jpg', '중국집', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategorySelect(CategoryName: '중국집')),
                                );
                              }),
                              SizedBox(width: 8),
                              _roundedContainer('assets/images/Chicken.png', '치킨', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategorySelect(CategoryName: '치킨')),
                                );
                              }),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              _roundedContainer('assets/images/Pizza.png', '피자', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategorySelect(CategoryName: '피자')),
                                );
                              }),
                              SizedBox(width: 8),
                              _roundedContainer('assets/images/Hamburger.png', '햄버거', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategorySelect(CategoryName: '햄버거')),
                                );
                              }),
                              SizedBox(width: 8),
                              _roundedContainer('assets/images/tteok.png', '분식', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategorySelect(CategoryName: '분식')),
                                );
                              }),
                              SizedBox(width: 8),
                              _roundedContainer('assets/images/Jokbal.jpg', '족발', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CategorySelect(CategoryName: '족발')),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),  //카테고리랑 환율 간격
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Container(
                              alignment: Alignment.centerLeft, // 제목을 화면 왼쪽에 정렬
                              padding: const EdgeInsets.all(16),
                              color: Colors.white, // 패널의 배경색을 흰색으로 설정
                              child: Text(
                                '실시간 환율(KRW)',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          body: Container(
                            height: screenHeight * 0.6,
                            color: Colors.white, // 패널의 내용 영역의 배경색을 흰색으로 설정
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              child: _exchangeRateContents(screenHeight, screenWidth),
                            ),
                          ),
                          isExpanded: _isExpanded, // 패널이 확장된 상태로 시작
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar(),
          _contents(),
        ],
      ),
    );
  }
}

void main() {
  runApp(HomePage());
}