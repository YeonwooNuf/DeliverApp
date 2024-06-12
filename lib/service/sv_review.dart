 import 'dart:convert';
import 'package:http/http.dart' as http;
 
 
 Future<double> getStoreRating(int storeId) async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:8080/reviews/$storeId/rating'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(utf8.decode(response.bodyBytes));
      if (responseData is Map<String, dynamic> && responseData.containsKey('averageRating')) {
        final averageRating = responseData['averageRating'];
        if (averageRating is double) {
          return averageRating;
        } else {
          throw Exception('Invalid average rating format: $averageRating');
        }
      } else {
        throw Exception('Invalid response format: $responseData');
      }
    } else {
      throw Exception('Failed to fetch store rating: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching store rating: $e');
    throw e;
  }
}