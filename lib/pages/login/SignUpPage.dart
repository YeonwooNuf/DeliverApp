import 'package:delivery/dto/user_dto.dart';
import 'package:delivery/pages/login/LoginPage.dart';
import 'package:delivery/service/sv_user.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isUserIdDuplicate = false;
  bool _isUserIdChecked = false;
  String _duplicateUserIdError = '';

  Future<void> checkDuplicateUserId() async {
    String userId = _idController.text;
    try {
      List<String> userIds = await getUserId();
      bool isDuplicate = userIds.contains(userId);
      setState(() {
        _isUserIdDuplicate = isDuplicate;
        _isUserIdChecked = true;
        _duplicateUserIdError = isDuplicate ? '아이디가 중복됩니다.' : '';
      });
      if (isDuplicate) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('중복된 아이디'),
              content: Text('아이디가 중복됩니다. 다른 아이디를 입력해주세요.'),
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
      } else if (userId.isEmpty) {
        setState(() {
          _isUserIdDuplicate = true;
          _isUserIdChecked = false;
          _duplicateUserIdError = '아이디를 입력해주세요.';
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('아이디 입력'),
              content: Text('아이디를 입력해주세요.'),
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('사용 가능한 아이디'),
              content: Text('사용 가능한 아이디입니다.'),
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
    } catch (error) {
      setState(() {
        _duplicateUserIdError = '서버 오류가 발생했습니다. 다시 시도해주세요.';
      });
    }
  }
  //회원가입 버튼 기능 구현 함수
  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      UserDto userDto = UserDto(
        userId: _idController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );
      try {
        // 사용자 등록 요청
        await saveUser(userDto);
        // 회원가입 성공 알림 메시지 띄우기
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('회원가입 성공'),
              content: Text('회원가입이 성공적으로 완료되었습니다.'),
              actions: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // 회원가입 성공 후 LoginPage로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        // 회원가입 실패 알림 메시지 띄우기
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('회원가입 실패'),
              content: Text('회원가입 중 오류가 발생했습니다. 다시 시도해주세요.'),
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
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '회원가입',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
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
          child: Form(
            key: _formKey,
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
                      child: TextFormField(
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: '아이디',
                          errorText:
                              _isUserIdDuplicate ? _duplicateUserIdError : null,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '아이디를 입력해주세요';
                          }
                          if (_isUserIdDuplicate) {
                            return _duplicateUserIdError;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    ElevatedButton(
                      onPressed: checkDuplicateUserId,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text(
                        '중복 확인',
                        style: TextStyle(color: Color(0xFF004AAD)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: '비밀번호'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: _passwordConfirmController,
                  decoration: InputDecoration(labelText: '비밀번호 확인'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호 확인을 입력해주세요';
                    }
                    if (value != _passwordController.text) {
                      return '비밀번호가 일치하지 않습니다';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.05),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: '이름'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이름을 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.05),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: '전화번호'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '전화번호를 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.05),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: '이메일'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  onPressed: _isUserIdChecked
                      ? signUp: null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        _isUserIdChecked ? Color(0xFF004AAD) : Colors.grey),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(screenWidth * 0.9, screenHeight * 0.05),
                    ),
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
