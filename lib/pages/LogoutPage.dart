import 'package:delivery/pages/LoginPage.dart';
import 'package:flutter/material.dart';

class LogoutPage extends StatefulWidget {
  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  void initState() {
    super.initState();
    // 페이지가 로드되자마자 로그아웃 확인 다이얼로그를 표시
    WidgetsBinding.instance.addPostFrameCallback((_) => _showLogoutConfirmation(context));
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 다이얼로그 바깥을 눌러도 닫히지 않게 설정
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃 확인'),
          content: Text('정말 로그아웃 하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('예'),
              onPressed: () {
                Navigator.of(context).pop();  // 다이얼로그를 닫습니다.
                _showLogoutCompleted(context);  // 로그아웃 완료 알림을 띄웁니다.
              },
            ),
            TextButton(
              child: Text('아니요'),
              onPressed: () {
                Navigator.of(context).pop();  // 다이얼로그를 닫습니다.
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutCompleted(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃 완료'),
          content: Text('로그아웃 되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();  // 다이얼로그를 닫습니다.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그아웃 페이지'),
      ),
      body: Center(
        child: Text('로그아웃 처리 중...'),
      ),
    );
  }
}
