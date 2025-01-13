import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:techx_app/pages/product/product_detail_page.dart';
import 'package:techx_app/utils/constant.dart';

class AllProductsPage extends StatefulWidget {
  final String productKey; // Key để xác định loại sản phẩm
  final String title; // Tiêu đề màn hình

  const AllProductsPage({
    super.key,
    required this.productKey,
    required this.title,
  });

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  bool _isLoading = true;
  List<dynamic> _products = [];
  bool _isAscending = true; // Biến để kiểm tra thứ tự sắp xếp

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Ánh xạ key với URL API
  String _getApiUrl(String key) {
    final baseUrl = Constant.api; // Địa chỉ API gốc
    switch (key) {
      case 'new-product':
        return '$baseUrl/products/new-product';
      case 'promotion-product':
        return '$baseUrl/products/promotion-product';
      default:
        throw Exception('Invalid product key');
    }
  }

  // Fetch danh sách sản phẩm từ API
  Future<void> fetchProducts() async {
    try {
      final apiUrl = _getApiUrl(widget.productKey); // Lấy URL từ key
      final response = await http.get(Uri.parse(apiUrl));
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

  // Sắp xếp sản phẩm theo giá
  void _sortProductsByPrice(bool isAscending) {
    setState(() {
      if (isAscending) {
        _products.sort((a, b) =>
            (double.tryParse(a['newPrice'].toString()) ?? 0.0)
                .compareTo(double.tryParse(b['newPrice'].toString()) ?? 0.0));
      } else {
        _products.sort((a, b) =>
            (double.tryParse(b['newPrice'].toString()) ?? 0.0)
                .compareTo(double.tryParse(a['newPrice'].toString()) ?? 0.0));
      }
      _isAscending = isAscending; // Cập nhật trạng thái sắp xếp
    });
  }

  // Format tiền tệ
  String formatCurrency(double originalCurrency) {
    var formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(originalCurrency);
  }

  // Decode UTF8
  String decodeUtf8(String value) {
    try {
      return utf8.decode(value.runes.toList());
    } catch (e) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            icon: const Icon(Icons.sort, color: Colors.black),
            offset: const Offset(0, 40), // Điều chỉnh vị trí menu xuất hiện
            onSelected: (value) {
              if (value == 'Giá tăng dần') {
                _sortProductsByPrice(true);
              } else if (value == 'Giá giảm dần') {
                _sortProductsByPrice(false);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Giá tăng dần',
                child: Row(
                  children: [
                    const Icon(Icons.arrow_upward, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text(
                      'Giá tăng dần',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'Giá giảm dần',
                child: Row(
                  children: [
                    const Icon(Icons.arrow_downward, color: Colors.red),
                    const SizedBox(width: 8),
                    const Text(
                      'Giá giảm dần',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Hiển thị 2 sản phẩm trên mỗi hàng
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          double newPrice =
              double.tryParse(product['newPrice'].toString()) ?? 0.0;

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
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
                  color: const Color(0xffF6F6F6),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hình ảnh sản phẩm
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8)),
                    child: Image.network(
                      product['images'][0]['url'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Tên sản phẩm
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Thông tin chi tiết sản phẩm
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${product['ram']} / ${product['storage']} / ${decodeUtf8(product['color'])}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff727880),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Giá sản phẩm
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      formatCurrency(newPrice),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
