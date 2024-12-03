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

class CartProvider with ChangeNotifier {
  List<ProductCart> _cartItems = [];

  List<ProductCart> get cartItems => _cartItems;

  // Thêm sản phẩm vào giỏ hàng
  void addProduct(ProductCart product) {
    _cartItems.add(product);
    notifyListeners();
  }

  // Xóa sản phẩm khỏi giỏ hàng
  void removeProduct(int productId) {
    _cartItems.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  // Lấy số lượng sản phẩm trong giỏ hàng
  int get itemCount => _cartItems.length;
}