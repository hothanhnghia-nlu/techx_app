class Province {
  final int provinceID;
  final String? provinceName;
  final String? code;

  Province({
    required this.provinceID,
    this.provinceName,
    this.code
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      provinceID: json['ProvinceID'],
      provinceName: json['ProvinceName'],
      code: json['Code'],
    );
  }
  
}
