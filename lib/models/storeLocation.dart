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

final List<StoreLocation> stores = [
  StoreLocation(
      id: '1',
      name: 'TechX Store Hải Dương',
      address: 'Số 82-84 phố Phạm Ngũ Lão, phường Phạm Ngũ Lão, Tp. Hải Dương',
      latitude: 20.9373,
      longitude: 106.3147,
      phone: '0220 3897183',
      workingHours: 'Thứ 2-6: 7:30-17:00\nThứ 7: 7:30-11:30',
  ),
  // Thêm các cửa hàng khác vào đây
];
