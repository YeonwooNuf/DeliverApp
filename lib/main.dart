import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:delivery/AddressChange.dart';
import 'package:delivery/pages/AddressMapPage.dart';
import 'package:delivery/pages/AddressInfo.dart';
import 'package:delivery/pages/FavoritePage.dart';
import 'package:delivery/pages/HomePage.dart';
import 'package:delivery/pages/MyPage.dart';
import 'package:delivery/pages/OrderHistoryPage.dart';
import 'package:delivery/widget/bottom_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemListNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              FavoritePage(),
              OrderHistoryPage(),
              MyPage(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
      routes: {
        '/addressMap': (context) => AddressMapPage(),
        '/addressRegister': (context) => AddressInfo(
              searchedAddress: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
