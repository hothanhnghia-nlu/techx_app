class Store {
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Store({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}
final List<Store> stores = [
  Store(
    name: 'Techx Hải Dương',
    address: 'Số 82 - 84 phố Phạm Ngũ Lão, Tp. Hải Dương, tỉnh Hải Dương',
    latitude: 10.777823642156697,
    longitude: 106.68016456092943,
  ),
  Store(
    name: 'Techx Hải Phòng',
    address: 'Số 5 Lý Tự Trọng, phường Hoàng Văn Thụ, Hải Phòng',
    latitude: 20.856994,
    longitude: 106.682182,
  ),
  Store(
    name: 'Techx Kiến An',
    address: 'Số 216 Trần Thành Ngọ, Kiến An, Hải Phòng',
    latitude: 20.827396,
    longitude: 106.625916,
  ),
];