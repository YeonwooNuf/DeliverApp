import 'dart:convert';
import 'package:delivery/dto/user_dto.dart';
import 'package:http/http.dart' as http;

//서버로 user정보를 전달해서 저장하는 코드
Future<void> saveUser(UserDto userDto) async {
  try {
    final serverUrl = 'http://localhost:8080/api/users/save-users';

    // HTTP POST 요청을 사용하여 사용자 데이터를 서버에 전송
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userDto.toJson()),
    );

    // 서버 응답 상태 코드 확인
    if (response.statusCode == 201) {
      // 성공적으로 사용자 데이터를 서버에 전송한 경우
      print("User Data sent successfully");
      
    } else {
      // 서버에서 다른 상태 코드를 반환하는 경우
      print("Failed to send user data: ${response.statusCode}");
      
    }
  } catch (e) {
    // HTTP 요청 중 오류 발생
    print("Failed to send user data: $e");
    
  }
}


// 서버에서 아이디를 받아오는 코드
Future<List<String>> getUserId() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/users/allUsers'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    // userId 값만 추출하여 반환( 유저정보값은 서버에서 다 받아왔으니 다른 값들 필요할 때 함수 따로 만들어서 구현하기)
    
    List<String> userId = data.map((user) => user['userId'].toString()).toList();
     
    return userId;
  } else {
    throw Exception('Failed to fetch user IDs');
  }

}

Future<List<String>> getUserNumber() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/users/allUsers'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    // userId 값만 추출하여 반환( 유저정보값은 서버에서 다 받아왔으니 다른 값들 필요할 때 함수 따로 만들어서 구현하기)
    List<String> userNumber = data.map((user) => user['userNumber'].toString()).toList();
    
    return userNumber;
  } else {
    throw Exception('Failed to fetch user Number');
  }

}
Future<List<String>> getUserPassword() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/users/allUsers'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    // userId 값만 추출하여 반환( 유저정보값은 서버에서 다 받아왔으니 다른 값들 필요할 때 함수 따로 만들어서 구현하기)
    
     List<String> password = data.map((user) => user['password'].toString()).toList();
     
    return password;
  } else {
    throw Exception('Failed to fetch user password');
  }

}
Future<List<String>> getUserName() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/users/allUsers'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    // userId 값만 추출하여 반환( 유저정보값은 서버에서 다 받아왔으니 다른 값들 필요할 때 함수 따로 만들어서 구현하기)
    
     List<String> name = data.map((user) => user['name'].toString()).toList();
     
    return name;
  } else {
    throw Exception('Failed to fetch user name');
  }

}
Future<List<String>> getUserPhone() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/users/allUsers'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    // userId 값만 추출하여 반환( 유저정보값은 서버에서 다 받아왔으니 다른 값들 필요할 때 함수 따로 만들어서 구현하기)
    
     List<String> phone = data.map((user) => user['phone'].toString()).toList();
     
    return phone;
  } else {
    throw Exception('Failed to fetch user phone');
  }

}
Future<List<String>> getUserEmail() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/users/allUsers'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    // userId 값만 추출하여 반환( 유저정보값은 서버에서 다 받아왔으니 다른 값들 필요할 때 함수 따로 만들어서 구현하기)
    
     List<String> email = data.map((user) => user['email'].toString()).toList();
    return email;
  } else {
    throw Exception('Failed to fetch user email');
  }

}
  