
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

}