import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.0.106:8080', // URL gốc API
        connectTimeout: const Duration(seconds: 5), // Đổi int thành Duration
        receiveTimeout: const Duration(seconds: 3), // Đổi int thành Duration
      ),  
    );

    // Thêm Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Lấy token từ SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('jwt_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (DioError e, handler) {
          // Xử lý lỗi
          if (e.response?.statusCode == 401) {
            // Có thể triển khai làm mới token tại đây
            print('Token hết hạn hoặc không hợp lệ.');
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}

// Sử dụng lớp DioClient
final dioClient = DioClient();