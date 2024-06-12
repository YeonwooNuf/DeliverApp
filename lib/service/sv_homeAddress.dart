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


//유저 번호에 맞는 모든 주소리스트들
  Future<List<Map<String, dynamic>>> getAddressListByuser(String userNumber) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/api/HomeAddress/allAddresses/$userNumber'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> addressList = List<Map<String, dynamic>>.from(data);


      print(' address list: $addressList');
      print(' address userNumber: $userNumber');
      return addressList;
    } else {
      throw Exception('Failed to load user addresses');
    }
    
  }
  //주소 삭제 기능
Future<void> deleteAddress(int userNumber, int homeAddressNumber) async {
  final url = 'http://localhost:8080/api/HomeAddress/delete-addresses/$userNumber/$homeAddressNumber';

  final response = await http.delete(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
  );

  if (response.statusCode != 200) {
    throw Exception('주소 삭제 실패');
  }
}









  //선택된 주소의 true false 값 넘기는 코드
  void updateAddressSelectStatus(int homeAddressNumber,  int userNumber, String address,String category,  bool selectStatus,) async {
  // URL to your backend API endpoint for updating address select status
  String apiUrl = 'http://localhost:8080/api/HomeAddress/updateAddressSelect';

  // JSON body data to send in the request
  Map<String, dynamic> requestBody = {
    'homeAddressNumber': homeAddressNumber,
    'addressUserNumber':userNumber,
    'address':address,
    'addressCategory':category,
    'addressSelect': selectStatus,
  };

  // Convert the request body to JSON format
  String jsonData = jsonEncode(requestBody);

  try {
    // Send a POST request to the backend API
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonData,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Handle successful response
      print('Address select status updated successfully');
    } else {
      // Handle other status codes (e.g., error or validation failure)
      print('Failed to update address select status: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any errors that occur during the HTTP request
    print('Error updating address select status: $error');
  }
}

  