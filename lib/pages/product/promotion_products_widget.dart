import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';
import 'package:techx_app/utils/constant.dart';

class PromotionProductsWidget extends StatefulWidget {
  const PromotionProductsWidget({super.key});

  @override
  State<PromotionProductsWidget> createState() => _PromotionProductsWidgetState();
}

class _PromotionProductsWidgetState extends State<PromotionProductsWidget> {
  bool isPressed = false;
  bool _isLoading = true;
  final baseUrl = Constant.api;
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    fetchPromotionProducts();
  }

  // Fetch data from API
  Future<void> fetchPromotionProducts() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/products/promotion-product"));
      if (response.statusCode == 200) {
        setState(() {
          _products = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  // Decode UTF8
  String decodeUtf8(String value) {
    try {
      return utf8.decode(value.runes.toList());
    } catch (e) {
      return value;
    }
  }

  // Format currency
  String formatCurrency(double originalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(originalCurrency);
  }

  // Calculate discount percentage
  String discountPercentage(double originalPrice, double newPrice) {
    double discount = ((originalPrice - newPrice) / originalPrice) * 100;
    return discount.round().toString();
  }

  // Add to Favorite button
  void _addToFavoriteButton() {
    setState(() {
      isPressed = !isPressed;
    });

    if (isPressed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã nhấn nút Thêm vào yêu thích'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int size = _products.length > 5 ? 5 : _products.length; // Ensure we don't exceed the number of products
    return SizedBox(
      height: 365,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < size; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ProductDetailPage(product: null,)));
                },
                child: _isLoading
                    ? buildShimmerPlaceholder()
                    : buildProductContainer(_products[i]),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildShimmerPlaceholder() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Color(hexColor('#F6F6F6')),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: buildShimmerTitle(),
          ),
          Center(
            child: buildShimmerImage(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmerTextLine(100, 20),
                  const SizedBox(height: 8),
                  buildShimmerTextLine(150, 15),
                  const SizedBox(height: 8),
                  buildShimmerTextLine(70, 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerTitle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget buildShimmerImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 150,
          width: 150,
          color: Colors.grey[300],
        ),
      ),
    );
  }

  Widget buildShimmerTextLine(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.grey[300],
      ),
    );
  }

  // Container after data has been loaded
  Widget buildProductContainer(dynamic product) {
    // Ensure proper conversion to double for prices
    double originalPrice = double.tryParse(product['originalPrice'].toString()) ?? 0.0;
    double newPrice = double.tryParse(product['newPrice'].toString()) ?? 0.0;

    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Color(hexColor('#F6F6F6')),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '${discountPercentage(originalPrice, newPrice)}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _addToFavoriteButton,
                  child: Icon(
                    isPressed ? Icons.favorite : Icons.favorite_border,
                    color: isPressed ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product['images'][0]['url'],
                height: 150,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product['ram'] + '/ ' + product['storage'] + '/ ' + decodeUtf8(product['color']),
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff727880),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    formatCurrency(newPrice),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}
