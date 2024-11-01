import 'package:techx_app/models/logistic/ward_model.dart';

class WardData {
  final int? code;
  final String? message;
  final List<Ward>? data;

  WardData ({
    this.code,
    this.message,
    this.data,
  });
  
  factory WardData.fromJson(Map<String, dynamic> json) {
    return WardData(
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List?)?.map((e) => Ward.fromJson(e)).toList(),
    );
  }
}
