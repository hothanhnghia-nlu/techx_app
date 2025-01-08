import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product_fvr_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProductPage extends StatefulWidget {
  const FavoriteProductPage({super.key});

  @override
  State<FavoriteProductPage> createState() => _FavoriteProductPageState();
}

class _FavoriteProductPageState extends State<FavoriteProductPage> {
  List<Map<String, dynamic>> favoriteProducts = [];
  bool _isLoading = true;
  bool isLoggedIn = false;
  String? userId;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    if (token != null) {
      setState(() {
        isLoggedIn = true;
      });
      _fetchUserId(token);
    } else {
      setState(() {
        isLoggedIn = false;
      });
      // Nếu không đăng nhập, yêu cầu đăng nhập lại
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> _fetchUserId(String token) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/users/user-info'), // API lấy thông tin người dùng
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final user = json.decode(response.body); // Giả sử lấy thông tin người dùng
      setState(() {
        userId = user['id'].toString();
      });
      // Sau khi lấy userId, gọi hàm fetchFavoriteProducts
      _fetchFavoriteProducts();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể lấy thông tin người dùng')),
      );
    }
  }

  Future<void> _fetchFavoriteProducts() async {
    if (userId == null) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/favorites/by-user'), // Đảm bảo URL API chính xác
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        favoriteProducts = List<Map<String, dynamic>>.from(json.decode(response.body));
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể tải danh sách yêu thích')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        title: const Text(
          'Yêu thích',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductFavoriteWidget(favoriteProducts: favoriteProducts),
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}
