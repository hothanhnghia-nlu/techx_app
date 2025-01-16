class StoreLocation {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String phone;
  final String workingHours;

  StoreLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.workingHours,
  });
}

// Danh sách các cửa hàng
final List<StoreLocation> stores = [
  StoreLocation(
    id: '1',
    name: 'TechX Store Tân Quy',
    address: '340 Nguyễn Thị Thập, Tân Quy, Quận 7, Hồ Chí Minh, Việt Nam',
    latitude: 10.738939618776795,
    longitude: 106.71249343052426,
    phone: '0220 3897183',
    workingHours: 'Thứ 2-6: 7:30-17:00\nThứ 7: 7:30-11:30',
  ),
  StoreLocation(
    id: '2',
    name: 'TechX Store Sài Gòn',
    address: 'Số 123 đường Hoàng Quốc Việt, Cầu Giấy, Hà Nội',
    latitude: 10.783770957473735,
    longitude: 106.70170985553985,
    phone: '024 12345678',
    workingHours: 'Thứ 2-6: 8:00-18:00\nThứ 7: 8:00-12:00',
  ),
  StoreLocation(
    id: '3',
    name: 'TechX Store Phú Mỹ Hưng',
    address: 'Toà nhà Capital Towner, 6 Nguyễn Khắc Viện, Tân Phú, Quận 7, Hồ Chí Minh, Việt Nam',
    latitude: 10.728536065194914,
    longitude: 106.72025796121238,
    phone: '024 12345678',
    workingHours: 'Thứ 2-6: 8:00-18:00\nThứ 7: 8:00-12:00',
  ),
  // Thêm các cửa hàng khác tại đây
];
