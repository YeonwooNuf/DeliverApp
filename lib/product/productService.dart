import 'dart:convert';
import 'package:http/http.dart' as http;
import 'productInfo.dart';

class ProductService {
  final String apiUrl = "http://localhost:8080/api/products"; // Spring Boot 서버 주소

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load produacts');
    }
  }
}
