import 'package:techx_app/models/product_model.dart';
import 'package:techx_app/models/provider_model.dart';

class Image {
  final int? id;
  final String? name, url;
  final Provider? provider;
  final List<Product>? productsList;

  Image({
    this.id,
    this.name,
    this.url,
    this.provider,
    this.productsList
  });

}