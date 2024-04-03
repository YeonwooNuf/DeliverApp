import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,//수평 가운데 정렬
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,//수평 가운데 정렬
                children: [
                  Image.asset(
                    'assets/images/오토바이1.png',
                    width: 300,
                    height: 400,
                    fit: BoxFit.cover 
                  ),
                ],
              ),
              Text('InhaDelivery',style: TextStyle(fontSize: 30),),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,//수평 가운데 정렬
                children: [
                  Image.asset(
                    'assets/images/kakao_login_large_narrow.png',
                    height: 60,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,//수평 가운데 정렬
                children: [
                  Image.asset(
                    'assets/images/android_neutral_sq_SU@2x.png',
                    height: 60,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
