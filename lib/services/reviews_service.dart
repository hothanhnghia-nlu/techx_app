import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:techx_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  final baseUrl = Constant.api;

 Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("accessToken");
}

  // Lấy tất cả các review của sản phẩm theo `productId`.
  Future<List<Map<String, dynamic>>> getAllReviewsByProduct(int productId) async {
    final url = Uri.parse('$baseUrl/reviews/by-product?productId=$productId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load reviews: ${response.body}');
    }
  }

  // Tạo một review mới cho sản phẩm.
  Future<Map<String, dynamic>> createReview(int productId, Map<String, dynamic> reviewData) async {
    final token = await getToken();
    if (token == null) {
      print("No token found!");
      return {};
    }

    final url = Uri.parse('$baseUrl/reviews');
    final request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      })
      ..fields['productId'] = productId.toString();

    // Add review data fields to the request
    reviewData.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        return json.decode(responseBody); // Return the parsed response
      } else {
        final responseBody = await response.stream.bytesToString();
        throw Exception('Failed to create review: ${response.statusCode} ${response.reasonPhrase} - $responseBody');
      }
    } catch (e) {
      print('Error during request: $e');
      throw Exception('Error during review creation: $e');
    }
  }

  // Xóa review theo `id`.
  Future<void> deleteReviewById(int id) async {
    final url = Uri.parse('$baseUrl/reviews/$id');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete review: ${response.body}');
    }
  }

}