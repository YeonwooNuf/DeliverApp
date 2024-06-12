import 'package:delivery/dto/homeAddress_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//서버로 집주소 전달

Future<void> saveHomeAddress(HomeAddressDto homeAddressDto) async {
  try {
    final serverUrl = 'http://localhost:8080/api/HomeAddress/save-HomeAddresses';

    // HTTP POST 요청을 사용하여 사용자 데이터를 서버에 전송
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(homeAddressDto.toJson()),
    );

    // 서버 응답 상태 코드 확인
    if (response.statusCode == 201) {
      // 성공적으로 즐겨찾기 데이터를 서버에 전송한 경우
      print("Favorite Data sent successfully");
      
    } else {
      // 서버에서 다른 상태 코드를 반환하는 경우
      print("서버에서 다른 상태 코드를 반환하는 경우: ${response.statusCode}");
      
    }
  } catch (e) {
    // HTTP 요청 중 오류 발생
    print("HTTP 요청 중 오류 발생: $e");
    
  }
}



//userNumber에 맞는 카테고리의 집주소 정보 받아옴 
Future<List<Map<String, dynamic>>> getAddressListByCategory(String userNumber, String category) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/api/HomeAddress/allAddresses/$userNumber'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> addressList = List<Map<String, dynamic>>.from(data);

      List<Map<String, dynamic>> filteredList = addressList.where((address) => address['addressCategory'] == category).toList();

      print('Filtered address list for category $category: $filteredList');
      print(' address list: $addressList');
      print(' address userNumber: $userNumber');
      return filteredList;
    } else {
      throw Exception('Failed to load user addresses');
    }
  }

  