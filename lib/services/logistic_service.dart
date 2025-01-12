import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:techx_app/models/logistic/districtData_model.dart';
import 'package:techx_app/models/logistic/district_model.dart';
import 'package:techx_app/models/logistic/provinceData_model.dart';
import 'package:techx_app/models/logistic/province_model.dart';
import 'package:techx_app/models/logistic/wardData_model.dart';
import 'package:techx_app/models/logistic/ward_model.dart';
import 'package:techx_app/utils/constant.dart';

import '../models/logistic/_address_suggestion.dart';

class LogisticService {
  final baseUrl = Constant.apiLogistic;
  final String token = '2e8e9a29-b5e2-11ed-bcba-eac62dba9bd9';

  // Get Province
  Future<ProvinceData> fetchProvinceData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/province'), headers: {
        'Token': token,
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return ProvinceData.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to load province data: ${response.reasonPhrase}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: $e');
    } on ClientException catch (e) {
      throw Exception('Client error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<Province>> getProvinces() async {
    try {
      ProvinceData provinceData = await fetchProvinceData();
      return provinceData.data ?? [];
    } catch (e) {
      throw Exception('Error fetching provinces: $e');
    }
  }

  // Get District
  Future<DistrictData> fetchDistrictData(int provinceId) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/district?province_id=$provinceId'),
          headers: {
            'Token': token,
          });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return DistrictData.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to load district data: ${response.reasonPhrase}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: $e');
    } on ClientException catch (e) {
      throw Exception('Client error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<District>> getDistricts(int provinceId) async {
    try {
      DistrictData districtData = await fetchDistrictData(provinceId);
      return districtData.data ?? [];
    } catch (e) {
      throw Exception('Error fetching districts: $e');
    }
  }

  // Get Ward
  Future<WardData> fetchWardData(int districtId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/ward?district_id=$districtId'), headers: {
        'Token': token,
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return WardData.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to load district data: ${response.reasonPhrase}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: $e');
    } on ClientException catch (e) {
      throw Exception('Client error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

// Get Ward
  Future<List<AddressSuggestion>> suggestedAddress(String input) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://rsapi.goong.io/place/autocomplete?api_key=gLhhNX9rqPVDM9uOenjpxLxmm8q7EM6qc3nZbISu&districtId&input=$input'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        final predictions = jsonResponse['predictions'] as List;
        // Chuyển đổi từng phần tử trong predictions thành AddressSuggestion
        return predictions.map((item) => AddressSuggestion.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load address suggestions: ${response.reasonPhrase}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: $e');
    } on ClientException catch (e) {
      throw Exception('Client error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<Ward>> getWards(int districtId) async {
    try {
      WardData wardData = await fetchWardData(districtId);
      return wardData.data ?? [];
    } catch (e) {
      throw Exception('Error fetching wards: $e');
    }
  }
}
