import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/address_model.dart';
import '../utils/constant.dart';

class AddressController {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constant.api,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<List<Address>> getAddresses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      final response = await _dio.get('/addresses/by-user',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print(data);
        return data.map((address) => Address.fromJson(address)).toList();
      } else {
        return [];
      }
    } on DioException catch (dioError) {
      print('Dio error: ${dioError.message}');
      return [];
    } catch (e) {
      print('Unexpected error: $e');
      return [];
    }
  }

  Future<Address?> getAddressesDefault() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      final response = await _dio.get('/addresses/default',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.statusCode == 200) {
        dynamic data = response.data; // API trả về danh sách
        print(data);
        if (data.isNotEmpty) {
          return Address.fromJson(data); // Lấy địa chỉ đầu tiên
        }
        return null; // Không có địa chỉ nào
      } else {
        return null;
      }
    } on DioException catch (dioError) {
      print('Dio error: ${dioError.message}');
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }

  Future<void> addAddress(Address address) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      FormData formData = FormData.fromMap({
        'fullName': address.fullName,
        'phone': address.phoneNumber,
        'detail': address.detail,
        'province': address.province,
        'city': address.city,
        'ward': address.ward,
        'note': address.note,
        'status': address.status,
      });
      final response = await _dio.post('/addresses',
          data: formData,
          options: Options(
            headers: {
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer $token'
            },
          ));
      if (response.statusCode == 403) {
        print(
            'Error: Forbidden - You do not have permission to add this address.');
        const SnackBar(
            content: Text('Failed to add address: Permission denied'));
      }
    } on DioException catch (dioError) {
      print('Dio error: ${dioError.message}');
      const SnackBar(
          content: Text('Failed to add address due to network error'));
    } catch (e) {
      print('Unexpected error: $e');
      const SnackBar(content: Text('Failed to add address'));
    }
  }

  Future<void> updateAddress(Address address) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      // Tạo dữ liệu JSON
      final data = address.toJson();
      final response = await _dio.put('/addresses',
          data: data,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.statusCode == 403) {
        print(
            'Error: Forbidden - You do not have permission to add this address.');
        const SnackBar(
            content: Text('Failed to add address: Permission denied'));
      }
    } on DioException catch (dioError) {
      print('Dio error: ${dioError.message}');
      const SnackBar(
          content: Text('Failed to add address due to network error'));
    } catch (e) {
      print('Unexpected error: $e');
      const SnackBar(content: Text('Failed to add address'));
    }
  }

  Future<void> removeAddress(int addressId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      final response = await _dio.delete('/addresses/$addressId',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.statusCode == 403) {
        print(
            'Error: Forbidden - You do not have permission to delete this address.');
        const SnackBar(
            content: Text('Failed to delete address: Permission denied'));
      }
    } on DioException catch (dioError) {
      print('Dio error: ${dioError.message}');
      const SnackBar(
          content: Text('Failed to delete address due to network error'));
    } catch (e) {
      print('Unexpected error: $e');
      const SnackBar(content: Text('Failed to delete address'));
    }
  }
}
