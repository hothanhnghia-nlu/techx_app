import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techx_app/utils/constant.dart';

import '../models/user_model.dart';

class AuthController {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constant.api,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(Constant.authLogin, data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final responseData = response.data;
        final token = responseData['accessToken'];
        if (token == null || token.isEmpty) {
          return 'Token không hợp lệ';
        }
        await _saveToken(token);

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        if (decodedToken.isEmpty) {
          return 'Token không hợp lệ';
        }
        String role = decodedToken['role'] ?? '';
        if (role == 'ROLE_ADMIN' || role == 'ROLE_USER') {
          return role;
        } else {
          return 'Không phân quyền hợp lệ';
        }
      } else {
        return 'Đăng nhập thất bại';
      }
    } catch (e) {
      return 'Lỗi khi đăng nhập';
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  Future<User?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token == null || token.isEmpty) {
      return null;
    }

    try {
      final response = await _dio.get('/users/user-info',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> logoutUser() async {
    try {
      await _dio.post('/auth/sign-out');
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProfile(String name, String phone, String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token == null || token.isEmpty) {
      return;
    }
    if (token.isNotEmpty && !JwtDecoder.isExpired(token)) {
      final decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
    }
    try {
      FormData formData = FormData.fromMap({
        'fullName': name,
        'phoneNumber': phone,
        'email': email,
      });

      await _dio.put('/users/update-user',
          data: formData,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'multipart/form-data',
            },
          ));
      await getUserInfo();
    } catch (e) {
      return;
    }
  }
}
