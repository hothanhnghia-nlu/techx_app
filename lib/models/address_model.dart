class Address {
  final int id;
  final String detail;
  final String ward;
  final String city;
  final String province;
  final String? note;
  final int status;

  Address({
    required this.id,
    required this.detail,
    required this.ward,
    required this.city,
    required this.province,
    this.note,
    required this.status,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      detail: json['detail'],
      ward: json['ward'],
      city: json['city'],
      province: json['province'],
      note: json['note'] ?? '',
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'detail': detail,
      'ward': ward,
      'city': city,
      'province': province,
      'note': note,
      'status': status,
    };
  }
}
