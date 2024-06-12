import 'dart:convert';
import 'package:http/http.dart' as http;

// 서버에서 매장아이디를 받아오는 코드
Future<List<Map<String, dynamic>>> getStoreId() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/store/allStores'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> storeId = data.map((store) => {'storeId': store['storeId']}).toList();
     
    return storeId;
  } else {
    throw Exception('Failed to fetch user IDs');
  }
}

// 서버에서 매장이름을 받아오는 코드
Future<List<Map<String, dynamic>>> getStoreName() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/store/allStores'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> storeName = data.map((store) => {'storeName': store['storeName']}).toList();
     
    return storeName;
  } else {
    throw Exception('Failed to fetch user IDs');
  }
}

// 서버에서 매장주소를 받아오는 코드
Future<List<Map<String, dynamic>>> getStoreAddress() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/store/allStores'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> storeAddress = data.map((store) => {'storeAddress': store['storeAddress']}).toList();
     
    return storeAddress;
  } else {
    throw Exception('Failed to fetch user IDs');
  }
}

// 서버에서 매장카테고리를 받아오는 코드
Future<List<Map<String, dynamic>>> getCategory() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/store/allStores'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> category = data.map((store) => {'category': store['category']}).toList();
     
    return category;
  } else {
    throw Exception('Failed to fetch user IDs');
  }
}

// 서버에서 매장이미지를 받아오는 코드
Future<List<Map<String, dynamic>>> getStoreImg() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/store/allStores'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> storeImg = data.map((store) => {'storeImg': store['storeImg']}).toList();
     
    return storeImg;
  } else {
    throw Exception('Failed to fetch user IDs');
  }
}

Future<List<Map<String, dynamic>>> getAllStores() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/store/allStores'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    // 매장 정보를 담을 리스트
    List<Map<String, dynamic>> stores = [];

    // 데이터를 순회하며 각 매장 정보를 맵 형태로 변환하여 리스트에 추가
    data.forEach((store) {
      Map<String, dynamic> storeInfo = {
        'storeId': store['storeId'],
        'storeName': store['storeName'],
        'storeAddress': store['storeAddress'],
        'category': store['category'],
        'storeImg': store['storeImg']
        // 다른 속성들도 필요에 따라 추가
      };
      stores.add(storeInfo);
    });

    return stores;
  } else {
    throw Exception('Failed to fetch store information');
  }
}

// Future<double> getStoreRating(int storeId) async {
//   final response = await http.get(Uri.parse('https://api.example.com/store/$storeId/rating'));

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     print('Fetched data for store $storeId: $data'); // 디버깅을 위한 출력

//     if (data is Map<String, dynamic>) {
//       final rating = data['rating'];
//       if (rating is num) {
//         return rating.toDouble();
//       } else {
//         throw TypeError();
//       }
//     } else {
//       throw TypeError();
//     }
//   } else {
//     throw Exception('Failed to load store rating');
//   }
// }
