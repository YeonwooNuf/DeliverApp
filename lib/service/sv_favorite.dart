
import 'package:delivery/dto/favorite_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//서버로 Favorite 전달해서 저장하는 코드
Future<void> saveFavorite(FavoriteDto favoriteDto) async {
  try {
    final serverUrl = 'http://localhost:8080/api/favorites/save-favorites';

    // HTTP POST 요청을 사용하여 사용자 데이터를 서버에 전송
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(favoriteDto.toJson()),
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

//서버에서 favorite정보 받아오는 코드
Future<List<Map<String, dynamic>>> getAllFavorite() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/favorites/allFavorites'),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    // 매장 정보를 담을 리스트
    List<Map<String, dynamic>> favorites = [];

    // 데이터를 순회하며 각 매장 정보를 맵 형태로 변환하여 리스트에 추가
    data.forEach((favorite) {
      Map<String, dynamic> favoriteInfo = {
        'favoriteUserNumber': favorite['favoriteUserNumber'],
        'favoriteStoreId': favorite['favoriteStoreId'],
        'favorite_storeImg': favorite['favorite_storeImg'],
        'favoriteStoreName': favorite['favoriteStoreName'],
        'rating': favorite['rating']
        // 다른 속성들도 필요에 따라 추가
      };
      favorites.add(favoriteInfo);
    });

    return favorites;
  } else {
    throw Exception('Failed to fetch favorite information');
  }
}

//즐겨찾기 삭제 기능
Future<void> deleteFavorite(int userNumber, int storeId) async {
  final url = 'http://localhost:8080/api/favorites/delete-favorites/$userNumber/$storeId';

  final response = await http.delete(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
  );

  if (response.statusCode != 200) {
    throw Exception('즐겨찾기 삭제 실패');
  }
}
//userNumber에 맞는 즐겨찾기 테이블만
Future<List<Map<String, dynamic>>> getUserFavorites(String userNumber) async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/favorites/userFavorites/$userNumber'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data);
  } else {
    throw Exception('Failed to load user favorites');
  }
}