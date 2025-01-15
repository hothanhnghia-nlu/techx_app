import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order_model.dart';
import '../utils/constant.dart';

class OrderController {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constant.api,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("accessToken");
  }

  Future<List<Order>> getOrdersByUser() async {
    try {
      final token = await getToken();
      log(token.toString());

      final response = await _dio.get('/orders/by-user',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ));

    
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        log(data.toString())
;        final ress = data.map((order) => Order.fromJson(order)).toList();
        return ress;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<Order>> getOrders() async {
    try {
      final response = await _dio.get('/orders/all-orders');
      if (response.statusCode == 200) {
        final res = (response.data as List)
            .map((order) => Order.fromJson(order))
            .toList();
        log("res.toString()");
        return res;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> updateOrderStatus(int orderId, Order order) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      log(token);
      FormData formData = FormData.fromMap({
        'id': orderId,
        'paymentMethod': order.paymentMethod,
        'status': order.status,
      });

      await _dio.put('${Constant.api}/orders/$orderId',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer $token'
            },
          ));
    } catch (e) {
      log("bị lỗi ");
      print(e);
    }
  }
}
