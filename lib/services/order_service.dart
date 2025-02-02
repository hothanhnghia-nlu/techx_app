import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';

class OrderService {
  final baseUrl = Constant.api;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  /// Đăng nhập người dùng và kiểm tra phân quyền
  Future<String?> createOrder(
      {required int idAddress,
      required double totalAmount,
      required String paymentMethod,
      required String? paymentDate,
      required int productID}) async {
    final url =
        Uri.parse('$baseUrl/orders?addressId=1'); // Thay đổi URL nếu cần
    final token = await getToken();
    try {
// Gửi yêu cầu đăng nhập
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'idAddress': idAddress,
          'totalAmount': totalAmount,
          'paymentMethod': paymentMethod,
          'paymentDate': paymentDate,
          'productID': productID,
        }),
      );

      if (response.statusCode == 201) {
        return "Dặt hàng thành công";
      } else {
        return 'Đặt hàng thất bại. Mã lỗi: ${response.statusCode}';
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return 'Lỗi khi gọi API: $e';
    }
  }
}
