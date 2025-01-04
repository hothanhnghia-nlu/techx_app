import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1/payment';

  // Tạo Payment Intent
  Future<Map<String, dynamic>> createPaymentIntent({
    required double amount,
  }) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/create-payment'),
          headers: {
            'Content-Type': 'application/json',
            // Thêm token nếu cần
          },
          body: jsonEncode({'amount': amount.toInt()}));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print('Payment Intent created: $result');
        return result;
      } else {
        throw Exception('Failed to create payment intent');
      }
    } catch (e) {
      print('Error creating payment intent: $e');
      rethrow;
    }
  }

  // Xác nhận thanh toán
  Future<String> confirmPayment(
      {required String paymentIntentId,
      required String paymentMethodId}) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/confirm'),
          headers: {
            'Content-Type': 'application/json',
            // Thêm token nếu cần
          },
          body: jsonEncode({
            'paymentIntentId': paymentIntentId,
            'paymentMethodId': paymentMethodId
          }));
      print(jsonDecode(response.body)['status']);
      return jsonDecode(response.body)['status'];
    } catch (e) {
      print('Error confirming payment: $e');
      rethrow;
    }
  }
}
