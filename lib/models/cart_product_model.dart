
class ProductCart {
  final int id;
  final String name;
  final String ram;
  final String color;
  final String storage;
  final double price;
        int quantity;
  final String imageUrl;
      final int status; 
  final int productId;  

  ProductCart({
    required this.id,
    required this.name,
    required this.ram,
    required this.color,
    required this.storage,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.status,
    required this.productId,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      id: json['id']  ?? 0,
      name: json['product']['name'] ?? 'Unknown Product',
      ram: json['product']['ram'] ?? 'N/A',
      color: json['product']['color'] ?? 'N/A',
      storage: json['product']['storage'] ?? 'N/A',
      price: (json['product']['newPrice'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      imageUrl: json['product']['images'] != null && json['product']['images'].isNotEmpty
          ? json['product']['images'][0]['url'] ?? 'No Image URL'
          : 'No Image URL',
      status: json['status'] ?? 0, 
      productId: json['product']['id'] ?? 0,
    );
  }
// Thêm phương thức toJson()
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ram': ram,
      'color': color,
      'storage': storage,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'status': status,
      'productId': productId,
    };
  }
  int getProductId() {
    return productId;
  }
  @override
  String toString() {
    return 'ProductCart(id: $id, name: $name, color: $color, ram: $ram, storage: $storage, price: $price, quantity: $quantity, imageUrl: $imageUrl, status: $status, productId: $productId)';
  }

}
