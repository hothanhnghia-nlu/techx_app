import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:techx_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  final baseUrl = Constant.reviews;

 Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("accessToken");
}

/// Lấy tất cả các review của sản phẩm theo `productId`.
  Future<List<Map<String, dynamic>>> getAllReviewsByProduct(int productId) async {
    final url = Uri.parse('$baseUrl/by-product?productId=$productId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load reviews: ${response.body}');
    }
  }

  /// Tạo một review mới cho sản phẩm.
  Future<Map<String, dynamic>> createReview(int productId, Map<String, dynamic> reviewData) async {
     final token = await getToken();
        if (token == null) {
          print("No token found!");
        }

    final url = Uri.parse('$baseUrl?productId=$productId');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
        },
      body: json.encode({'productId': productId, ...reviewData}),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create review: ${response.body}');
    }
  }

  /// Xóa review theo `id`.
  Future<void> deleteReviewById(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete review: ${response.body}');
    }
  }

}