import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
//            appBar: AppBar(title: Text(title)),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/오토바이1.png',
                      width: 160,
                      height: 160, 
                    ),
                  ),
                  Container(
                     child:  Image.asset('assets/images/kakao_login_large_wide.png'),
                      margin: EdgeInsets.only(top: 20),
                      height: 60,
                      ),
                  Container(
                      child: Image.asset('assets/images/android_light_sq_ctn@2x.png'),
                      margin: EdgeInsets.only(top: 8),
                      height: 60,
                      color: Colors.red,
                      ),
                ],
              ),
            )));
  }
}