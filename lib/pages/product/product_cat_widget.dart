import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';
import 'package:techx_app/utils/constant.dart';

class ProductCatWidget extends StatefulWidget {
  const ProductCatWidget({super.key, required this.providerId});
  final int providerId; // Nhận ID từ ProductCatPage

  @override
  State<ProductCatWidget> createState() => _ProductCatWidgetState();
}


class _ProductCatWidgetState extends State<ProductCatWidget> {
  bool _isLoading = true;
  final baseUrl = Constant.api;
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Fetch data from API
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode == 200) {
        final allProducts = json.decode(response.body);
        setState(() {
          _products = allProducts.where((product) {
            return product['provider']['id'] == widget.providerId;
          }).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
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

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.54,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: _isLoading
          ? List.generate(
        10, // Hiển thị 10 shimmer placeholders khi đang tải
            (_) => buildShimmerPlaceholder(),
      )
          : _products.map((product) {
        return GestureDetector(
          onTap: () {
            // Điều hướng đến ProductDetailPage và truyền sản phẩm vào
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(product: product), // Truyền sản phẩm vào đây
              ),
            );
          },
          child: buildProductContainer(product),  // Truyền 'product' vào đây
        );

      }).toList(),
    );
  }




  // Shimmer Placeholder for Loading State
  Widget buildShimmerPlaceholder() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
          Shimmer.fromColors(
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
          ),
          
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 150,
              width: 150,
              color: Colors.grey[300],
            ),
          ),
          
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 150,
              color: Colors.grey[300],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 100,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  // Build Product Container with Data
  Widget buildProductContainer(dynamic product) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(hexColor('#4C53A5')),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${discountPercentage(product['originalPrice'].toDouble(), product['newPrice'].toDouble())}%',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã nhấn nút Thêm vào yêu thích'),
                    ),
                  );
                },
                child: const Icon(Icons.favorite_border, color: Colors.red),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Image.network(
              product['images'][0]['url'],
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              product['name'],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              product['ram'] + '/ ' + product['storage'] + '/ ' + decodeUtf8(product['color']),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff727880),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              formatCurrency(product['newPrice'].toDouble()),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function to convert hex color string to integer
int hexColor(String color) {
  String newColor = "0xff$color";
  newColor = newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}