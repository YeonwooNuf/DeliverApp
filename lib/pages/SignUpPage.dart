import 'package:delivery/dto/user_dto.dart';
import 'package:delivery/service/sv_user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SignUpPage(),
  ));
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
// 아이디 입력 필드를 관리하는 컨트롤러
  TextEditingController _idController = TextEditingController();

// 비밀번호 입력 필드를 관리하는 컨트롤러
  TextEditingController _passwordController = TextEditingController();

// 비밀번호 확인 입력 필드를 관리하는 컨트롤러
  TextEditingController _passwordConfirmController = TextEditingController();

// 이름 입력 필드를 관리하는 컨트롤러
  TextEditingController _nameController = TextEditingController();

// 전화번호 입력 필드를 관리하는 컨트롤러
  TextEditingController _phoneController = TextEditingController();

// 이메일 입력 필드를 관리하는 컨트롤러
  TextEditingController _emailController = TextEditingController();

  bool _passwordsMatch = true; // 비밀번호와 비밀번호 확인이 일치하는지 여부를 저장하는 변수

  //입력된 정보를 UserDTO 객체로 만듦
  // void _signUp() {
  //   UserDto userdtO = UserDto(
  //     userId: _idController.text,
  //     password: _passwordController.text,
  //     name: _nameController.text,
  //     phone: _phoneController.text,
  //     email: _emailController.text,
  //   );
  //   print('회원가입 정보: ${userdtO}');
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '회원가입',
          textAlign: TextAlign.center, // 텍스트를 가운데 정렬
        ),
        centerTitle: true, // title을 가운데 정렬
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/InhaDelivery.png',
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.3,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _idController,
                      decoration: InputDecoration(labelText: '아이디'),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05), // 간격 조정
                  ElevatedButton(
                    onPressed: () {
                      // 여기에 아이디 중복 확인 로직을 작성
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // 버튼의 배경색을 설정
                    ),
                    child: Text(
                      '중복 확인',
                      style: TextStyle(color: Color(0xFF004AAD)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: '비밀번호'),
                obscureText: true,
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: _passwordConfirmController,
                decoration: InputDecoration(labelText: '비밀번호 확인'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    // 비밀번호 확인 필드의 값이 변경될 때마다 비교하여 동일한지 확인
                    _passwordsMatch = _passwordController.text == value;
                  });
                },
              ),
              // 비밀번호 확인 메시지 표시
              if (!_passwordsMatch)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '비밀번호가 일치하지 않습니다',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: screenHeight * 0.05),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '이름'),
              ),
              SizedBox(height: screenHeight * 0.05),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: '전화번호'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: screenHeight * 0.05),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: '이메일'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: screenHeight * 0.05),
              ElevatedButton(
                onPressed: () {
                  // "회원가입" 버튼이 눌렸을 때 saveUser 함수 호출
                  UserDto userDto = UserDto(
                    userId: _idController.text,
                    password: _passwordController.text,
                    name: _nameController.text,
                    phone: _phoneController.text,
                    email: _emailController.text,
                  );
                  // JSON 데이터 출력
                  print('전송되는 JSON 데이터: ${userDto.toJson()}');
                  // saveUser 함수 호출
                  saveUser(userDto);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF004AAD)), // 버튼의 배경색을 설정
                  fixedSize: MaterialStateProperty.all<Size>(Size(
                      screenWidth * 0.9, screenHeight * 0.05)), // 버튼의 고정 크기 설정
                ),
                child: Text(
                  '회원가입',
                  style: TextStyle(color: Colors.white), // 텍스트 색상을 변경
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
