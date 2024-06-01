// import 'dart:convert';
// import 'package:http/http.dart' as http;


// // 서버에서 상품아이디를 받아오는 코드
// Future<List<Map<String, dynamic>>> getProductId() async {
//   final response = await http.get(
//     Uri.parse('http://localhost:8080/api/menu/allMenus'),
//     headers: {'Content-Type': 'application/json'},
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
//     Future<List<Map<String, dynamic>>> productId = data.map((menu) => menu['productId'].toString()).toList();
     
//     return productId;
//   } else {
//     throw Exception('Failed to fetch user IDs');
//   }

// }
// // 서버에서 매장아이디를 받아오는 코드
// Future<List<String>> getStoreId() async {
//   final response = await http.get(
//     Uri.parse('http://localhost:8080/api/menu/allMenus'),
//     headers: {'Content-Type': 'application/json'},
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
//     List<String> storeId = data.map((menu) => menu['storeId'].toString()).toList();
     
//     return storeId;
//   } else {
//     throw Exception('Failed to fetch user IDs');
//   }

// }
// // 서버에서 상품이름을 받아오는 코드
// Future<List<String>> getProductName() async {
//   final response = await http.get(
//     Uri.parse('http://localhost:8080/api/menu/allMenus'),
//     headers: {'Content-Type': 'application/json'},
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
//     List<String> productName = data.map((menu) => menu['productName'].toString()).toList();
     
//     return productName;
//   } else {
//     throw Exception('Failed to fetch user IDs');
//   }

// }
// // 서버에서 상품가격를 받아오는 코드
// Future<List<String>> getProductPrice() async {
//   final response = await http.get(
//     Uri.parse('http://localhost:8080/api/menu/allMenus'),
//     headers: {'Content-Type': 'application/json'},
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
//     List<String> price = data.map((menu) => menu['price'].toString()).toList();
     
//     return price;
//   } else {
//     throw Exception('Failed to fetch user IDs');
//   }

// }
// // 서버에서 상품이미지를 받아오는 코드
// Future<List<String>> getProductImg() async {
//   final response = await http.get(
//     Uri.parse('http://localhost:8080/api/menu/allMenus'),
//     headers: {'Content-Type': 'application/json'},
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
//     List<String> productImg = data.map((menu) => menu['productImg'].toString()).toList();
     
//     return productImg;
//   } else {
//     throw Exception('Failed to fetch user IDs');
//   }

// }
