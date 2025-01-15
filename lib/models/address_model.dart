class Address {
  final int id;
   String? fullName;
   String? phoneNumber;
  late String detail;
  late String ward;
  late String city;
  late String province;
  late String? note;
  late int status;

  Address({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
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
      fullName: json['fulllName'] != null
          ?json['fulllName']
          : "",
      phoneNumber: json['phone'] != null
          ?json['phone']
          : "",
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
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'detail': detail,
      'ward': ward,
      'city': city,
      'province': province,
      'note': note,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'Address{id: $id, fullName: $fullName, phoneNumber: $phoneNumber, detail: $detail, ward: $ward, city: $city, province: $province, note: $note, status: $status}';
  }
}
