
import 'package:techx_app/models/logistic/district_model.dart';

class DistrictData {
  final int? code;
  final String? message;
  final List<District>? data;

  DistrictData({
    this.code,
    this.message,
    this.data
  });
  
  factory DistrictData.fromJson(Map<String, dynamic> json) {
    return DistrictData(
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List?)?.map((e) => District.fromJson(e)).toList(),
    );
  }
}
