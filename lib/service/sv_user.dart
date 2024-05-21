import 'dart:convert';
import 'package:delivery/dto/user_dto.dart';
import 'package:http/http.dart' as http;

Future<void> saveUser(UserDto userDto) async {
  try {
    // 서버 주소를 환경 변수로부터 동적으로 가져올 수도 있습니다.
    final serverUrl = 'http://localhost:8080/api/users';

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
      // 여기서 원하는 작업을 수행할 수 있습니다. 예를 들어, 다음과 같이 페이지를 이동할 수 있습니다.
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // 서버에서 다른 상태 코드를 반환하는 경우
      print("Failed to send user data: ${response.statusCode}");
      // 사용자에게 적절한 오류 메시지를 표시할 수 있습니다.
      // 예: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send user data")));
    }
  } catch (e) {
    // HTTP 요청 중 오류 발생
    print("Failed to send user data: $e");
    // 사용자에게 적절한 오류 메시지를 표시할 수 있습니다.
    // 예: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to send user data: $e")));
  }
}
