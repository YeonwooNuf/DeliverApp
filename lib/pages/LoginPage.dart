import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _idController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //수평 가운데 정렬
            children: [
              Padding(
                padding: EdgeInsets.only(
                    ), // 이미지와 ID 입력란 사이의 간격 조정
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //수평 가운데 정렬
                  children: [
                    Image.asset(
                      'assets/images/InhaDelivery.png',
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // 아이디와 로고 사이 간격
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: '아이디',
                ),
              ),
              SizedBox(height: screenHeight * 0.005), // 아이디와 비번 사이 간격
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () {
                  // 로그인 버튼을 누를 때 동작
                },
                child: Container(
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    color: Color(0xFF004AAD), // 파란색 배경
                    borderRadius: BorderRadius.circular(10), // 모서리를 둥글게
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20), // 내부 여백 추가
                  alignment: Alignment.center, // 가운데 정렬
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: Colors.white, // 흰색 텍스트
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.01),
              GestureDetector(
                onTap: () {
                  // 회원가입 버튼을 누를 때 동작
                },
                child: Container(
                  width: screenWidth * 0.6,
                  decoration: BoxDecoration(
                    color: Color(0xFF004AAD), // 파란색 배경
                    borderRadius: BorderRadius.circular(10), // 모서리를 둥글게
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20), // 내부 여백 추가
                  alignment: Alignment.center, // 가운데 정렬
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.white, // 흰색 텍스트
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
