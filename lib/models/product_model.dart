
class Product {
  final int? id;
  final String? name, imageUrl, brand, color, screen, operatingSystem, camera, cpu, ram, storage, battery, description;
  final int? vendorId;
  final double? originalPrice, newPrice;
  final int? quantity, status;

  Product({
    this.id,
    this.name,
    this.vendorId,
    this.imageUrl,
    this.brand,
    this.originalPrice,
    this.newPrice,
    this.quantity,
    this.color,
    this.screen,
    this.operatingSystem,
    this.camera,
    this.cpu,
    this.ram,
    this.storage,
    this.battery,
    this.description,
    this.status
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images'] != null && (json['images'] as List).isNotEmpty
          ? json['images'][0]['url']
          : 'https://via.placeholder.com/150',
      brand: json['brand'],
      color: json['color'],
      screen: json['screen'],
      operatingSystem: json['operatingSystem'],
      camera: json['camera'],
      cpu: json['cpu'],
      ram: json['ram'],
      storage: json['storage'],
      battery: json['battery'],
      description: json['description'],
      vendorId: json['vendorId'],
      originalPrice: json['originalPrice'],
      newPrice: json['newPrice'],
      quantity: json['quantity'],
      status: json['status'],
    );
  }

}