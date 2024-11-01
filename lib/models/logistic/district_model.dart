
class District {
  final int districtID;
  final int? provinceID;
  final String? districtName;

  District({
    required this.districtID,
    this.provinceID,
    this.districtName
  });
  
  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      districtID: json['DistrictID'],
      provinceID: json['ProvinceID'],
      districtName: json['DistrictName'],
    );
  }
}
