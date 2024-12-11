import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:techx_app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  final baseUrl = Constant.api;
  ValueNotifier<int> cartItemSize = ValueNotifier<int>(0);
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }
  CartService._internal();

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("accessToken");
}

Future<dynamic> getCartsByUser() async {
    try {
        final token = await getToken();
        if (token == null) {
          print("No token found!");
          return;
        }
      final response = await http.get(
        Uri.parse('$baseUrl/carts/by-user'),
        headers: { 
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',}
      );
       
      if (response.statusCode == 200) {
           final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Cart failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

Future<void> updateCart(var cartProduct) async {
  try {
     final token = await getToken();
        if (token == null) {
          print("No token found!");
          return;
        }
    final response = await http.put(
      Uri.parse('$baseUrl/carts/${cartProduct.id}'),
      body: jsonEncode({  // Sử dụng jsonEncode để chuyển Map thành JSON string
        'product': {
          'id': cartProduct.productId
        },
        'quantity': cartProduct.quantity,
        'status': cartProduct.status
      }),
      headers: { 
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'  // Đảm bảo Content-Type là application/json
      },
    );
    
    if (response.statusCode == 200) {
      print('Đã cập nhật sản phẩm');
    } else {
      throw Exception('Failed to update cart');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<void> removeProduct(int cartId) async {
  try {
     final token = await getToken();
        if (token == null) {
          print("No token found!");
          return;
        }
    final response = await http.delete(
      Uri.parse('$baseUrl/carts/$cartId'),
      headers: { 
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',}
      );
    
    if (response.statusCode == 200) {
      cartItemSize.value -= 1;
      print('Sản phẩm đã bị xóa khỏi giỏ hàng');
    } else {
      throw Exception('Failed to remove product');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<void> removeProductAll() async {
  try {
     final token = await getToken();
        if (token == null) {
          print("No token found!");
          return;
        }
    final response = await http.delete(
      Uri.parse('$baseUrl/carts'),
        headers: { 
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );
    
    if (response.statusCode == 200) {
      cartItemSize.value = 0;
      print('Tất cả sản phẩm đã bị xóa khỏi giỏ hàng');
    } else {
      throw Exception('Failed to remove all cart product');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<void> addProductCart(int productId) async {
  try {
        final token = await getToken();
        if (token == null) {
          print("No token found!");
          return;
        }
    final response = await http.post(
      Uri.parse('$baseUrl/carts?productId=$productId'),
      headers: { 
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'  // Đảm bảo Content-Type là application/json
      },
    );
    
    if (response.statusCode == 201) {
      // Cập nhật số lượng sản phẩm trong giỏ hàng ở giao diện home_page
      cartItemSize.value += 1;
          print('Sản phẩm đã thêm giỏ hàng: $cartItemSize');
    } else {
      throw Exception('Failed to add product');
    }
  } catch (e) {
    throw Exception('Error remove product: $e');
  }
}

 Future<int> getQuantityProduct() async {
    try {
       final token = await getToken();
        if (token == null) {
          print("No token found!");
        }
      final response = await http.get(
        Uri.parse('$baseUrl/carts/quantity'),
        headers: { 
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        int data = json.decode(response.body);
        print('Số lượng sản phẩm giỏ hàng - getQuantityProduct: $data');
        return data;
      } else {
        throw Exception('Failed to fetch quantity');
      }
    } catch (e) {
      throw Exception('Error fetching quantity: $e');
    }
  }

}