class AddressSuggestion {
  final String description;
  final String province;
  final String commune;
  final String district;
  final String detailAddress;

  AddressSuggestion({
    required this.description,
    required this.province,
    required this.commune,
    required this.district,
    required this.detailAddress,
  });

  factory AddressSuggestion.fromJson(Map<String, dynamic> json) {
    final compound = json['compound'] ?? {};
    final description = json['description'] ?? '';
    final detailAddress = _extractDetailAddress(description, compound);

    return AddressSuggestion(
      description: description,
      province: compound['province'] ?? '',
      commune: compound['commune'] ?? '',
      district: compound['district'] ?? '',
      detailAddress: detailAddress,
    );
  }

  // Hàm để tách phần chi tiết địa chỉ (phần còn lại của description)
  static String _extractDetailAddress(String description, Map<String, dynamic> compound) {
    final province = compound['province'] ?? '';
    final district = compound['district'] ?? '';
    final commune = compound['commune'] ?? '';

    // Tách chuỗi `description` thành danh sách các phần tử dựa trên dấu phẩy
    List<String> parts = description.split(',').map((part) => part.trim()).toList();

    // Loại bỏ các thành phần khớp với `province`, `district`, hoặc `commune`
    parts.removeWhere((part) =>
    part == province ||
        part == district ||
        part == commune);

    // Ghép lại các phần còn lại để tạo `detailAddress`
    return parts.join(', ').trim();
  }

  @override
  String toString() {
    return 'AddressSuggestion{description: $description, province: $province, commune: $commune, district: $district, detailAddress: $detailAddress}';
  }
}