import 'package:techx_app/models/address_model.dart';
import 'package:techx_app/models/user_model.dart';

class Order {
  final int id;
  final User user;
  final Address address;
  final double total;
  final String paymentMethod;
  final String note;
  final DateTime orderDate;
  final DateTime? paymentDate;
  final int status;
  final List<OrderDetail> orderDetails;

  Order({
    required this.id,
    required this.user,
    required this.address,
    required this.total,
    required this.paymentMethod,
    required this.note,
    required this.orderDate,
    required this.paymentDate,
    required this.status,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: User.fromJson(json['user']),
      address: Address.fromJson(json['address']),
      total: json['total'],
      paymentMethod: json['paymentMethod'],
      note: json['note'],
      orderDate: DateTime.parse(json['orderDate']),
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'])
          : null,
      status: json['status'],
      orderDetails: (json['orderDetails'] as List)
          .map((detail) => OrderDetail.fromJson(detail))
          .toList(),
    );
  }
  // copyWith method
  Order copyWith({
    int? id,
    User? user,
    Address? address,
    double? total,
    String? paymentMethod,
    String? note,
    DateTime? orderDate,
    DateTime? paymentDate,
    int? status,
    List<OrderDetail>? orderDetails,
  }) {
    return Order(
      id: id ?? this.id,
      user: user ?? this.user,
      address: address ?? this.address,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      note: note ?? this.note,
      orderDate: orderDate ?? this.orderDate,
      paymentDate: paymentDate ?? this.paymentDate,
      status: status ?? this.status,
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }
}

class OrderDetail {
  final int id;
  final Product product;
  final int quantity;
  final double price;

  OrderDetail({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final double originalPrice;
  final double newPrice;
  final String color;
  final String ram;
  final String storage;
  final int producedYear;
  final List<ImageProduct> images;

  Product({
    required this.id,
    required this.name,
    required this.originalPrice,
    required this.newPrice,
    required this.color,
    required this.ram,
    required this.storage,
    required this.producedYear,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      originalPrice: json['originalPrice'],
      newPrice: json['newPrice'],
      color: json['color'],
      ram: json['ram'],
      storage: json['storage'],
      producedYear: json['producedYear'],
      images: (json['images'] as List)
          .map((image) => ImageProduct.fromJson(image))
          .toList(),
    );
  }
}

class ImageProduct {
  final int id;
  final String name;
  final String url;

  ImageProduct({
    required this.id,
    required this.name,
    required this.url,
  });

  factory ImageProduct.fromJson(Map<String, dynamic> json) {
    return ImageProduct(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}
