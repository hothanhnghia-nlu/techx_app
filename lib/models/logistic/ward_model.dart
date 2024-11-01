
class Ward {
  final String? wardCode;
  final int? districtID;
  final String? wardName;

  Ward({
    this.wardCode,
    this.districtID,
    this.wardName
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      wardCode: json['WardCode'],
      districtID: json['DistrictID'],
      wardName: json['WardName'],
    );
  }
}
