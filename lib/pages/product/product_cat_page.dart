import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:techx_app/utils/constant.dart'; // Import constant.dart

final logger = Logger();

List<String> list = <String>['Giá Cao - Thấp', 'Giá Thấp - Cao'];

class ProductCatPage extends StatefulWidget {
  final int providerId; // ID của hãng
  final String providerName; // Tên của hãng

  const ProductCatPage({
    super.key,
    required this.providerId,
    required this.providerName,
  });

  @override
  State<ProductCatPage> createState() => _ProductCatPageState();
}

class _ProductCatPageState extends State<ProductCatPage> {
  String dropdownValue = list.first;
  bool _isLoading = true;
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProductsByProvider();
  }

  Future<void> fetchProductsByProvider() async {
    final String apiUrl = "${Constant.api}/products"; // Sử dụng API từ constant.dart
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> allProducts = json.decode(response.body);
        setState(() {
          _products = allProducts
              .where((product) => product['provider']['id'] == widget.providerId)
              .toList();
          _isLoading = false;
        });
        logger.i("Fetched ${_products.length} products for providerId ${widget.providerId}");
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      logger.e("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Color(hexColor('#F0F1F0')),
        title: Text(
          widget.providerName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _products.isEmpty
          ? const Center(
        child: Text(
          "Không có sản phẩm nào.",
          style: TextStyle(fontSize: 16),
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.filter_list),
                      const SizedBox(width: 5),
                      DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.grey[300],
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                            sortProducts();
                          });
                        },
                        items: list.map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // GridView để hiển thị sản phẩm theo dạng lưới
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Mỗi hàng 2 ô
                crossAxisSpacing: 10, // Khoảng cách giữa các ô
                mainAxisSpacing: 10, // Khoảng cách giữa các ô
                childAspectRatio: 0.75, // Tỷ lệ chiều rộng/chiều cao của ô
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return buildProductItem(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  void sortProducts() {
    if (dropdownValue == 'Giá Cao - Thấp') {
      _products.sort((a, b) => b['newPrice'].compareTo(a['newPrice']));
    } else if (dropdownValue == 'Giá Thấp - Cao') {
      _products.sort((a, b) => a['newPrice'].compareTo(b['newPrice']));
    }
    logger.i("Products sorted by $dropdownValue");
  }

  Widget buildProductItem(dynamic product) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      surfaceTintColor: Colors.white,
      elevation: 3,
      shadowColor: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product['images'][0]['url'],
            fit: BoxFit.cover,
            width: double.infinity,
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['name'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Giá: ${product['newPrice']}₫",
              style: const TextStyle(color: Colors.red, fontSize: 14),
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
