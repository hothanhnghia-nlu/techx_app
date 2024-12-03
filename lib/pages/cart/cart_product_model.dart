import 'package:flutter/cupertino.dart';

class ProductCart {
  final int id;
  final String name;
  final double price;
        int quantity;
  final String imageUrl;
      final int status; 
  final int productId;  

  ProductCart({
    required this.id,
    required this.name,
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
      price: (json['product']['newPrice']?? 0).toDouble(),
      quantity: json['quantity']?? 0,
      imageUrl: json['product']['imageUrl']?? 'Not Find URL',
      status: json['status'] ?? 0, 
      productId: json['product']['id'] ?? 0,
    );
  }
  @override
  String toString() {
    return 'ProductCart(id: $id, name: $name, price: $price, quantity: $quantity, imageUrl: $imageUrl, status: $status, productId: $productId)';
  }
}
