import 'package:delivery/main.dart';
import 'package:delivery/pages/MyPage.dart';
import 'package:delivery/service/sv_user.dart';
import 'package:flutter/material.dart';
import 'package:delivery/pages/login/SignUpPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _idController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    Future<void> login() async {
      String userId = _idController.text;
      String password = _passwordController.text;

      if (userId.isEmpty || password.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('입력 오류'),
              content: Text('아이디와 비밀번호를 모두 입력해주세요.'),
              actions: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }
      //로그인 기능 구현 (각 인덱스에 맞는 아이디와 비밀번호)
      try {
        List<String> userIds = await getUserId();
        List<String> passwords = await getUserPassword();
        List<String> phones = await getUserPhone();
        List<String> names = await getUserName(); // 사용자 이름을 가져오는 함수
        int index = userIds.indexOf(userId); // 입력한 아이디의 인덱스 찾기

        if (index != -1 &&
            passwords.length > index &&
            passwords[index] == password) {
          // 해당하는 아이디가 존재하고 비밀번호가 일치하는 경우
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainApp(name: names[index], phone: phones[index])),
          );

           MyPage(name: names[index], phone: phones[index]);
          
        } else {
          // 아이디 또는 비밀번호가 올바르지 않은 경우
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('로그인 실패'),
                content: Text('아이디 또는 비밀번호가 올바르지 않습니다.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('확인'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('서버 오류'),
              content: Text('로그인 중 오류가 발생했습니다. 다시 시도해주세요.'),
              actions: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //수평 가운데 정렬
          children: [
            Padding(
              padding: EdgeInsets.only(), // 이미지와 ID 입력란 사이의 간격 조정
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
              obscureText: true, // 비밀번호 마스킹 처리
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            GestureDetector(
              onTap: login,
              child: Container(
                width: screenWidth * 0.7,
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
                // 회원가입 버튼을 누를 때 SignUpPage로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Container(
                width: screenWidth * 0.7,
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
            SizedBox(height: screenHeight * 0.01),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 가로 방향으로 공간을 균등하게 배치
              children: [
                GestureDetector(
                  onTap: () {
                    // 아이디 찾기 버튼을 누를 때 동작
                  },
                  child: Text(
                    '아이디 찾기',
                    style: TextStyle(
                        color: Color(0xFF004AAD), // 파란색 텍스트
                        fontSize: 16,
                        decoration: TextDecoration.underline, // 밑줄 추가
                        decorationColor: Color(0xFF004AAD)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // 비밀번호 찾기 버튼을 누를 때 동작
                  },
                  child: Text(
                    '비밀번호 찾기',
                    style: TextStyle(
                        color: Color(0xFF004AAD), // 파란색 텍스트
                        fontSize: 16,
                        decoration: TextDecoration.underline, // 밑줄 추가
                        decorationColor: Color(0xFF004AAD)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}