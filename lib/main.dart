import 'package:delivery/pages/PaymentPage.dart';
import 'package:delivery/pages/address/AddressInfo.dart';
import 'package:delivery/pages/address/AddressMapPage.dart';
import 'package:delivery/pages/address/AddressRegisterPage.dart';
import 'package:delivery/pages/FavoritePage.dart';
import 'package:delivery/pages/HomePage.dart';
import 'package:delivery/pages/MyPage.dart';
import 'package:delivery/pages/OrderHistoryPage.dart';
import 'package:delivery/pages/login/LoginPage.dart';
import 'package:delivery/widget/bottom_bar.dart';
import 'package:flutter/material.dart';
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

class MainApp extends StatelessWidget {
  // MainPage로 LoginPage의 이름과 전화번호를 전달해줌.
  final String name;
  final String phone;
  final String userNumber;

  MainApp({required this.name, required this.phone, required this.userNumber}); // 생성자

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomePage(userNumber: userNumber,),
            FavoritePage(userNumber: userNumber,),
            OrderHistoryPage(userNumber: userNumber,),

            MyPage(name: name, phone: phone,userNumber: userNumber,),

          ],
        ),
        bottomNavigationBar: Bottom(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'title',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        hintColor: Colors.white,
        fontFamily: "MangoDdobak",
      ),
      home: LoginPage(), // 초기 화면을 LoginPage로 설정
      routes: {
        '/main': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          if (args == null) {
            return Scaffold(
              body: Center(
                child: Text('No arguments passed'),
              ),
            );
          }
          return MainApp(
            name: args['name'],
            phone: args['phone'],
            userNumber: args['userNumber'],
          );
        },
        '/addressMap': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final userNumber = args?['userNumber']; // userNumber 가져오기
          if (userNumber == null) {
            return Scaffold(
              body: Center(
                child: Text('No user number provided'),
              ),
            );
          }
          return AddressMapPage(userNumber: userNumber);
        },
        '/addressRegister': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final userNumber = args?['userNumber']; // userNumber 가져오기
          final address = args?['address'] as String?;
          if (address == null || userNumber == null) {
            return Scaffold(
              body: Center(
                child: Text('No address or user number provided'),
              ),
            );
          }
          return AddressInfo(searchedAddress: address, userNumber: userNumber);
        },
      },
    );
  }
}

