import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchOrders(String userNumber) async {
    var url = Uri.http('localhost:8080', '/orderhistory', {'userNumber': userNumber});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var utf8Body = utf8.decode(response.bodyBytes);
      List<dynamic> data = json.decode(utf8Body);
      return data.map((order) => order as Map<String, dynamic>).toList();
    } else {
      return [];
    }
  }
Future<String?> fetchImageUrl(int storeId) async {
  var url = Uri.http('localhost:8080', '/api/store/$storeId/image');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    try {
      return response.body;
    } catch (e) {
      print('JSON 파싱 오류: $e');
      print(response.body);

      return null;
    }
  } else {
    print('HTTP 요청 오류: ${response.statusCode}');
    return null;
  }
}