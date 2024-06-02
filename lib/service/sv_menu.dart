import 'dart:convert';
import 'package:http/http.dart' as http;


// 서버에서 상품아이디를 받아오는 코드
Future<List<Map<String, dynamic>>> getProductId() async {
   final response = await http.get(
    Uri.parse('http://localhost:8080/api/menu/allMenus'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> productId = data.map((menu) => {'productId': menu['productId']}).toList();
    return productId;
  } else {
    throw Exception('Failed to fetch user IDs');
  }

}
// 서버에서 매장아이디를 받아오는 코드
Future<List<Map<String, dynamic>>> getMenu_StoreId() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/menu/allMenus'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> menu_storeId = data.map((menu) => {'menu_storeId': menu['menu_storeId']}).toList();
    return menu_storeId;
  } else {
    throw Exception('Failed to fetch user IDs');
  }

}
// 서버에서 상품이름을 받아오는 코드
Future<List<Map<String, dynamic>>> getProductName() async {
   final response = await http.get(
    Uri.parse('http://localhost:8080/api/menu/allMenus'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> productName = data.map((menu) => {'productName': menu['productName']}).toList();
    return productName;
  } else {
    throw Exception('Failed to fetch user IDs');
  }

}
// 서버에서 상품가격를 받아오는 코드
Future<List<Map<String, dynamic>>> getPrice() async {
   final response = await http.get(
    Uri.parse('http://localhost:8080/api/menu/allMenus'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> price = data.map((menu) => {'price': menu['price']}).toList();
    return price;
  } else {
    throw Exception('Failed to fetch user IDs');
  }

}
// 서버에서 상품이미지를 받아오는 코드
Future<List<Map<String, dynamic>>> getProductImg() async {
   final response = await http.get(
    Uri.parse('http://localhost:8080/api/menu/allMenus'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    
    List<Map<String, dynamic>> productImg = data.map((menu) => {'productImg': menu['productImg']}).toList();
    return productImg;
  } else {
    throw Exception('Failed to fetch user IDs');
  }

}
//메뉴 정보 전체를 받아오는 코드
Future<List<Map<String, dynamic>>> getAllMenus() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/menu/allMenus'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    // 메뉴 정보를 담을 리스트
    List<Map<String, dynamic>> menus = [];

    // 데이터를 순회하며 각 메뉴 정보를 맵 형태로 변환하여 리스트에 추가
    data.forEach((menu) {
      Map<String, dynamic> menuInfo = {
        'productId': menu['productId'],
        'menu_storeId' : menu['menu_storeId'],
        'productName': menu['productName'],
        'price': menu['price'],
        'productImg': menu['productImg']
      };
      menus.add(menuInfo);
    });

    return menus;
  } else {
    throw Exception('Failed to fetch store information');
  }
}
