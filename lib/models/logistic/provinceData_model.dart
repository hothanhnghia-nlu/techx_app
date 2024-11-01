
import 'package:techx_app/models/logistic/province_model.dart';

class ProvinceData {
  final int? code;
  final String? message;
  final List<Province>? data;

  ProvinceData({
    this.code,
    this.message,
    this.data
  });

  factory ProvinceData.fromJson(Map<String, dynamic> json) {
    return ProvinceData(
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List?)?.map((e) => Province.fromJson(e)).toList(),
    );
  }
}
