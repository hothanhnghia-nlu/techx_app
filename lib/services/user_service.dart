import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constant.dart' as api;
import 'package:jwt_decoder/jwt_decoder.dart'; // Thêm thư viện jwt_decoder
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  /// Đăng ký người dùng mới
  Future<String?> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse(api.Constant.userRegister);

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['fullName'] = fullName;
      request.fields['email'] = email;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['password'] = password;
      request.fields['status'] = '1';
      request.fields['role'] = '1';

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Đăng ký thành công'; // Đăng ký thành công, không có lỗi
      } else {
        return 'Đăng ký thất bại. Mã lỗi: ${response.statusCode}';
      }
    } catch (e) {
      return 'Lỗi kết nối hoặc server: $e';
    }
  }

  /// Đăng nhập người dùng và kiểm tra phân quyền
  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(api.Constant.authLogin); // Thay đổi URL nếu cần

    try {
      // Gửi yêu cầu đăng nhập
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Lấy token từ response
        final responseData = jsonDecode(response.body);
        final token = responseData['accessToken'];
        // Kiểm tra nếu token hợp lệ
        if (token == null || token.isEmpty) {
          return 'Token không hợp lệ';
        }
        // Lưu token vào SharedPreferences
        await _saveToken(token);

        // Giải mã JWT để lấy thông tin phân quyền
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        if (decodedToken.isEmpty) {
          return 'Token không hợp lệ';
        }
        String role = decodedToken['role'] ?? ''; // Kiểm tra vai trò
        print('role là $role');
        // Kiểm tra phân quyền và trả về thông báo
        if (role == 'ROLE_ADMIN') {
          return 'ROLE_ADMIN'; // Trả về role admin
        } else if (role == 'ROLE_USER') {
          return 'ROLE_USER'; // Trả về role user
        } else {
          return 'Không phân quyền hợp lệ';
        }
      } else {
        return 'Đăng nhập thất bại. Mã lỗi: ${response.statusCode}';
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return 'Lỗi khi gọi API: $e';
    }
  }

  // Lưu token vào SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", token);
    print('Token saved: $token');
  }

  // Lấy token từ SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
